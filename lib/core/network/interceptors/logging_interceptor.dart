import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs traffic in debug builds only, with credentials and tokens redacted.
///
/// Release builds skip this entirely — request/response bodies here carry
/// customer and financial data and must not reach device logs.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  static const _redactedKeys = <String>{
    'password',
    'newPassword',
    'oldPassword',
    'token',
    'accessToken',
    'refreshToken',
    'secret',
  };

  /// Fields large enough to bury the useful part of the log.
  static const _bulkyKeys = <String>{'zatcaXml', 'zatcaQr'};

  static const _maxBodyChars = 800;

  Object? _sanitize(Object? body) {
    if (body is Map) {
      return {
        for (final entry in body.entries)
          entry.key: _redactedKeys.contains(entry.key)
              ? '***'
              : _bulkyKeys.contains(entry.key)
                  ? '<${entry.key} omitted>'
                  : _sanitize(entry.value),
      };
    }
    if (body is List) {
      // Logging one sample keeps a 500-row list from flooding the console.
      if (body.length > 3) {
        return [..._sanitize(body.take(3).toList()) as List, '…+${body.length - 3} more'];
      }
      return body.map(_sanitize).toList();
    }
    return body;
  }

  String _truncate(Object? value) {
    final text = '${_sanitize(value)}';
    if (text.length <= _maxBodyChars) return text;
    return '${text.substring(0, _maxBodyChars)}… (${text.length} chars)';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('→ ${options.method} ${options.baseUrl}${options.path}'
          '${options.queryParameters.isEmpty ? '' : '?${options.queryParameters}'}');
      if (options.data != null) debugPrint('  body: ${_truncate(options.data)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint('← ${response.statusCode} ${response.requestOptions.path}');
      debugPrint('  data: ${_truncate(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('✖ ${err.response?.statusCode ?? err.type.name} '
          '${err.requestOptions.path}');
      if (err.response?.data != null) {
        debugPrint('  error: ${_truncate(err.response?.data)}');
      }
    }
    handler.next(err);
  }
}
