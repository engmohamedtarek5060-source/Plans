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

/// Creates a company account and signs the new owner in.
///
/// There is no `role` parameter: the backend rejects one outright
/// (`property role should not exist`) and derives the account's permissions
/// from being a company's first user. The device-level role is a separate,
/// local concept.
class RegisterUser {
  const RegisterUser(this._repository);
  final AuthRepository _repository;

  Future<AuthUser> call({
    required String name,
    required String email,
    required String password,
    required String companyName,
  }) =>
      _repository.register(
        name: name,
        email: email,
        password: password,
        companyName: companyName,
      );
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
