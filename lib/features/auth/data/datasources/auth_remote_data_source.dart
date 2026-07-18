import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/auth/data/models/auth_user_model.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';

/// Thin transport layer for the `/auth` endpoints.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._api);

  final ApiService _api;

  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    final json = await _api.postObject(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
    );
    return AuthSessionModel.fromJson(json);
  }

  Future<AuthSessionModel> register({
    required String name,
    required String email,
    required String password,
    required String companyName,
  }) async {
    final json = await _api.postObject(
      ApiEndpoints.register,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'companyName': companyName,
      },
    );
    return AuthSessionModel.fromJson(json);
  }

  Future<AuthUser> me() async {
    final json = await _api.getObject(ApiEndpoints.me);
    return AuthUserModel.fromJson(json);
  }

  /// Revokes the session server-side.
  ///
  /// [refreshToken] is required by the backend — omitting it returns
  /// 400 VALIDATION_ERROR ("refreshToken must be a string") and, worse, leaves
  /// the refresh token valid after the user has logged out.
  Future<void> logout({required String? refreshToken}) => _api.post(
        ApiEndpoints.logout,
        body: {'refreshToken': refreshToken ?? ''},
      );
}
