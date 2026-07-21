import 'package:dio/dio.dart';
import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/network/interceptors/auth_interceptor.dart';
import 'package:saudiaaaa/core/network/interceptors/logging_interceptor.dart';
import 'package:saudiaaaa/core/network/interceptors/retry_interceptor.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
import 'package:saudiaaaa/core/utils/json_parse.dart';

/// The app's single HTTP entry point.
///
/// Wraps Dio so that no caller ever sees a [DioException]: every failure leaves
/// here as a typed [ApiException]. Repositories depend on this, not on Dio.
class ApiService {
  ApiService({
    required TokenStorage tokenStorage,
    required SessionEvents sessionEvents,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // Let every status through to our own mapping so error bodies survive.
      validateStatus: (status) => status != null && status < 500,
    );

    _dio.interceptors.addAll([
      AuthInterceptor(
        tokenStorage: tokenStorage,
        sessionEvents: sessionEvents,
      ),
      const LoggingInterceptor(),
      // Last, so a retried request re-enters the chain above it and is signed
      // with the current token rather than replaying a stale header.
      RetryInterceptor(dio: _dio),
    ]);
  }

  final Dio _dio;

  /// Exposed for tests that need to stub the transport.
  Dio get dio => _dio;

  Future<Response<dynamic>> _send(
    Future<Response<dynamic>> Function() call,
  ) async {
    try {
      final response = await call();
      // validateStatus lets 4xx reach here; convert them to typed failures.
      final status = response.statusCode ?? 0;
      if (status >= 400) {
        throw DioException.badResponse(
          statusCode: status,
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.malformed(e.toString());
    }
  }

  /// GET returning a JSON object.
  Future<Map<String, dynamic>> getObject(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final res = await _send(() => _dio.get<dynamic>(path, queryParameters: query));
    final data = res.data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw ApiException.malformed('Expected a JSON object at $path');
  }

  /// GET returning a JSON array (bare, or wrapped in `data`/`items`).
  Future<List<Map<String, dynamic>>> getList(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final res = await _send(() => _dio.get<dynamic>(path, queryParameters: query));
    return asListResponse(res.data);
  }

  /// POST returning a JSON object.
  Future<Map<String, dynamic>> postObject(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    final res = await _send(
      () => _dio.post<dynamic>(path, data: body, queryParameters: query),
    );
    final data = res.data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw ApiException.malformed('Expected a JSON object at $path');
  }

  /// POST where the response body is irrelevant (e.g. logout).
  Future<void> post(String path, {Object? body}) =>
      _send(() => _dio.post<dynamic>(path, data: body));
}
