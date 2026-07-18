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
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    final path = err.requestOptions.path;

    // A 401 on an authenticated call means our token is dead. Drop it and tell
    // the app to log out. Login failures are left alone for the form to show.
    if (status == 401 && !_isPublic(path)) {
      _tokenStorage.clear();
      _sessionEvents.signalUnauthorized();
    }

    handler.next(err);
  }
}
