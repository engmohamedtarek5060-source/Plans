import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  /// Creates a company and its first (ADMIN) user, then signs them in.
  ///
  /// [companyName] is required by the backend, which has no notion of the
  /// device-level [UserRole]: registering always provisions a company. Client
  /// accounts are customer contacts provisioned by a company, and no endpoint
  /// creates them — so there is deliberately no client registration path.
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
    required String companyName,
  });

  Future<void> logout();

  /// Returns the user for a persisted session, or null when there is none —
  /// or when the stored token is no longer accepted by the backend.
  Future<AuthUser?> restoreSession();
}
