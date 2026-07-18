import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  const LoginUser(this._repository);
  final AuthRepository _repository;

  Future<AuthUser> call({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
}

class LogoutUser {
  const LogoutUser(this._repository);
  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}

/// Resolves a persisted session at startup, if there is one.
class RestoreSession {
  const RestoreSession(this._repository);
  final AuthRepository _repository;

  Future<AuthUser?> call() => _repository.restoreSession();
}
