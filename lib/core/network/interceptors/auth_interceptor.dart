import 'package:dio/dio.dart';
import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';

/// Attaches the bearer token to outgoing requests and turns a rejected token
/// into an app-wide logout.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
    required SessionEvents sessionEvents,
  })  : _tokenStorage = tokenStorage,
        _sessionEvents = sessionEvents;

  final TokenStorage _tokenStorage;
  final SessionEvents _sessionEvents;

  /// Endpoints that establish a session; sending a stale token to these would
  /// be pointless, and a 401 from them means "bad credentials", not "session
  /// expired" — so they must never trigger the forced-logout path.
  static const _publicPaths = <String>{
    ApiEndpoints.login,
    ApiEndpoints.register,
    ApiEndpoints.refresh,
  };

  bool _isPublic(String path) => _publicPaths.any(path.contains);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (!_isPublic(options.path)) {
      final token = _tokenStorage.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // ApiService uses `validateStatus: < 500`, so a 401 arrives here as a
    // resolved response rather than an error — this is where the expired-token
    // logout must be detected. (The `onError` path below only ever sees a 401
    // if that policy changes; both are kept so the logout fires either way.)
    _handleUnauthorized(response.statusCode, response.requestOptions.path);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _handleUnauthorized(err.response?.statusCode, err.requestOptions.path);
    handler.next(err);
  }

  /// A 401 on an authenticated call means our token is dead. Drop it and tell
  /// the app to log out. Login/register/refresh failures are left alone for the
  /// form to show ("bad credentials", not "session expired").
  void _handleUnauthorized(int? status, String path) {
    if (status == 401 && !_isPublic(path)) {
      _tokenStorage.clear();
      _sessionEvents.signalUnauthorized();
    }
  }
}
