import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/domain/repositories/role_repository.dart';

/// Resolves the persisted entry role at startup, if there is one.
class GetSavedRole {
  const GetSavedRole(this._repository);
  final RoleRepository _repository;

  Future<UserRole?> call() => _repository.getSavedRole();
}

class SaveRole {
  const SaveRole(this._repository);
  final RoleRepository _repository;

  Future<void> call(UserRole role) => _repository.saveRole(role);
}

class ClearRole {
  const ClearRole(this._repository);
  final RoleRepository _repository;

  Future<void> call() => _repository.clearRole();
}
