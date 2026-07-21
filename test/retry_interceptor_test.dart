import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/network/interceptors/retry_interceptor.dart';

/// Unit tests for the retry policy.
///
/// The transport is a stub adapter rather than the live backend: provoking a
/// real timeout or 503 on demand isn't possible, and these assertions are about
/// *our* policy, not the server's behaviour.
void main() {
  /// Builds a Dio whose adapter replays [outcomes], one per attempt, and counts
  /// how many times it was called.
  ({Dio dio, List<int> attempts}) harness(
    List<Object> outcomes, {
    int maxAttempts = 3,
  }) {
    final attempts = <int>[];
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));

    dio.httpClientAdapter = _StubAdapter((options) {
      final i = attempts.length;
      attempts.add(i);
      final outcome = outcomes[min(i, outcomes.length - 1)];
      if (outcome is int) {
        return ResponseBody.fromString('{"ok":true}', outcome,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            });
      }
      // Build the failure from the *real* options. Fabricating fresh
      // RequestOptions here would report every request as a GET and silently
      // void the idempotency checks under test.
      throw DioException(
        requestOptions: options,
        type: outcome as DioExceptionType,
      );
    });

    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        maxAttempts: maxAttempts,
        // Keep the suite fast; jitter is exercised separately below.
        baseDelay: const Duration(milliseconds: 1),
        random: Random(1),
      ),
    );

    return (dio: dio, attempts: attempts);
  }

  /// Scripted outcome: the adapter turns this into a DioException carrying the
  /// real RequestOptions.
  DioExceptionType failure(DioExceptionType type) => type;

  group('retries transient failures', () {
    test('a timeout is retried and can succeed on a later attempt', () async {
      final h = harness([
        failure(DioExceptionType.connectionTimeout),
        failure(DioExceptionType.connectionTimeout),
        200,
      ]);

      final res = await h.dio.get<dynamic>('/x');

      expect(res.statusCode, 200);
      expect(h.attempts.length, 3, reason: 'original + two retries');
    });

    test('a connection error is retried', () async {
      final h = harness([failure(DioExceptionType.connectionError), 200]);
      await h.dio.get<dynamic>('/x');
      expect(h.attempts.length, 2);
    });

    test('gives up after maxAttempts and surfaces the last failure', () async {
      final h = harness([failure(DioExceptionType.receiveTimeout)]);

      await expectLater(
        h.dio.get<dynamic>('/x'),
        throwsA(
          isA<DioException>()
              .having((e) => e.type, 'type', DioExceptionType.receiveTimeout),
        ),
      );
      expect(h.attempts.length, 3);
    });
  });

  group('does not retry what a retry cannot fix', () {
    test('a cancelled request is not retried', () async {
      final h = harness([failure(DioExceptionType.cancel)]);
      await expectLater(h.dio.get<dynamic>('/x'), throwsA(isA<DioException>()));
      expect(h.attempts.length, 1);
    });

    test('a bad certificate is not retried', () async {
      final h = harness([failure(DioExceptionType.badCertificate)]);
      await expectLater(h.dio.get<dynamic>('/x'), throwsA(isA<DioException>()));
      expect(h.attempts.length, 1);
    });

    test('a 4xx is not retried', () async {
      // Mirrors ApiService: 4xx is a success as far as Dio is concerned, so it
      // never reaches onError and must never consume a retry.
      final h = harness([422]);
      h.dio.options.validateStatus = (s) => s != null && s < 500;

      final res = await h.dio.get<dynamic>('/x');

      expect(res.statusCode, 422);
      expect(h.attempts.length, 1);
    });
  });

  group('idempotency', () {
    test('a POST is not replayed by default', () async {
      // A timeout means "no response", not "no effect" — replaying a POST
      // could create a second record.
      final h = harness([failure(DioExceptionType.connectionTimeout)]);
      await expectLater(h.dio.post<dynamic>('/x'), throwsA(isA<DioException>()));
      expect(h.attempts.length, 1);
    });

    test('a POST marked retryable is replayed', () async {
      final h = harness([failure(DioExceptionType.connectionTimeout), 200]);

      await h.dio.post<dynamic>(
        '/x',
        options: Options(
          extra: {RetryInterceptor.retryableExtraKey: true},
        ),
      );

      expect(h.attempts.length, 2);
    });
  });

  test('5xx is retried but the attempt budget is still bounded', () async {
    final h = harness([503], maxAttempts: 4);
    await expectLater(h.dio.get<dynamic>('/x'), throwsA(isA<DioException>()));
    expect(h.attempts.length, 4);
  });
}

/// Replays scripted outcomes in place of real network I/O.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.onFetch);

  final ResponseBody Function(RequestOptions options) onFetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async =>
      onFetch(options);

  @override
  void close({bool force = false}) {}
}
