import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';

/// Maps the backend user payload onto [AuthUser].
///
/// Shape (verified against POST /auth/login and GET /auth/me):
/// ```
/// {id:int, name:String, email:String, role:String,
///  twoFactorEnabled?:bool, company:{id:int, name:String, currency:String}}
/// ```
class AuthUserModel {
  const AuthUserModel._();

  static AuthUser fromJson(Map<String, dynamic> json) {
    final name = asString(json['name'], fallback: asString(json['email']));
    final company = asMap(json['company']);

    return AuthUser(
      // The API uses an int id; the domain models it as an opaque String.
      id: asString(json['id']),
      email: asString(json['email']),
      fullName: name,
      // No Arabic name exists server-side; reuse rather than invent one.
      fullNameAr: name,
      role: asString(json['role']),
      company: company.isEmpty
          ? null
          : AuthCompany(
              id: asInt(company['id']),
              name: asString(company['name']),
              currency: asString(company['currency'], fallback: 'SAR'),
            ),
    );
  }

  /// Round-trips the user through secure storage so a restarted app can show
  /// the account before /auth/me returns.
  static Map<String, dynamic> toJson(AuthUser user) => {
        'id': user.id,
        'name': user.fullName,
        'email': user.email,
        'role': user.role,
        if (user.company != null)
          'company': {
            'id': user.company!.id,
            'name': user.company!.name,
            'currency': user.company!.currency,
          },
      };
}

/// The full login/register response: tokens plus the authenticated user.
class AuthSessionModel {
  const AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String? refreshToken;
  final AuthUser user;

  /// Shape: `{token, accessToken, refreshToken, user:{...}}`, optionally
  /// wrapped as `{data: {...}}`. `token` and `accessToken` are duplicates
  /// today; prefer `accessToken` and fall back so either alone is enough.
  static AuthSessionModel fromJson(Map<String, dynamic> json) {
    final payload = asMap(json['data']).isNotEmpty ? asMap(json['data']) : json;
    final token = asStringOrNull(payload['accessToken']) ??
        asStringOrNull(payload['token']) ??
        '';

    return AuthSessionModel(
      accessToken: token,
      refreshToken: asStringOrNull(payload['refreshToken']),
      user: AuthUserModel.fromJson(asMap(payload['user'])),
    );
  }
}
