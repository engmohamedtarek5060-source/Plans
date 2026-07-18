import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  /// Returns the user for a persisted session, or null when there is none —
  /// or when the stored token is no longer accepted by the backend.
  Future<AuthUser?> restoreSession();
}
