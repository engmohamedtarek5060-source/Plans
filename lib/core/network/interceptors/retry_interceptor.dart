import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

/// Retries requests that failed for reasons a second attempt might fix.
///
/// Placed last in the chain so it re-sends through [AuthInterceptor] — a retry
/// therefore picks up the current token rather than replaying a stale header.
///
/// Two deliberate limits:
///
/// * **Only idempotent methods.** A timeout means "no response", not "no
///   effect": the server may have committed the write and lost the reply on the
///   way back. Replaying a POST would create a second invoice. Callers that
///   know a POST is safe can opt in per-request with [retryableExtraKey].
/// * **Only transient failures.** [ApiService] is configured with
///   `validateStatus: < 500`, so 4xx never reaches `onError` and never gets
///   retried here — which is what we want. A 401, 404 or 422 is deterministic;
///   retrying it just burns the user's battery to fail again. That also spares
///   429 from an automatic retry, so the rate-limited `/auth/login` is left for
///   the user to trigger deliberately.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Dio dio,
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 400),
    Random? random,
  })  : _dio = dio,
        _random = random ?? Random();

  final Dio _dio;

  /// Total attempts including the first. 3 = one original + two retries.
  final int maxAttempts;

  /// First backoff step; doubles each attempt (400ms, 800ms, ...).
  final Duration baseDelay;

  final Random _random;

  /// Per-request opt-in for non-idempotent methods:
  /// `Options(extra: {RetryInterceptor.retryableExtraKey: true})`.
  static const String retryableExtraKey = 'plans.retryable';

  /// Internal attempt counter, carried on the request as it is re-sent.
  static const String _attemptExtraKey = 'plans.retryAttempt';

  /// Methods safe to replay: re-sending them cannot create a second record.
  static const _idempotentMethods = <String>{'GET', 'HEAD', 'OPTIONS'};

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptExtraKey] as int?) ?? 1;

    if (!_shouldRetry(err) || attempt >= maxAttempts) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(_delayFor(attempt));

    // The request may have been cancelled while we were backing off.
    if (options.cancelToken?.isCancelled ?? false) {
      handler.next(err);
      return;
    }

    options.extra[_attemptExtraKey] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      // Hand the *new* failure back to the chain: its attempt counter is
      // already incremented, so this recurses at most maxAttempts times.
      handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    final options = err.requestOptions;

    final optedIn = options.extra[retryableExtraKey] == true;
    if (!optedIn && !_idempotentMethods.contains(options.method.toUpperCase())) {
      return false;
    }

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;

      case DioExceptionType.badResponse:
        // Only 5xx arrives here (validateStatus lets 4xx through as success),
        // and those are the ones worth a second look.
        final status = err.response?.statusCode ?? 0;
        return status >= 500;

      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return false;

      case DioExceptionType.unknown:
        // Socket-level faults surface here; a genuine parse bug would too, but
        // those fail identically on retry and stop at maxAttempts.
        return err.error is! FormatException;

      case DioExceptionType.transformTimeout:
        return false;
    }
  }

  /// Exponential backoff with full jitter. The jitter matters more than the
  /// growth: without it, every screen that failed during one outage retries in
  /// the same millisecond and stampedes the server as it recovers.
  Duration _delayFor(int attempt) {
    final ceiling = baseDelay.inMilliseconds * pow(2, attempt - 1).toInt();
    return Duration(milliseconds: _random.nextInt(ceiling + 1) + ceiling ~/ 2);
  }
}
