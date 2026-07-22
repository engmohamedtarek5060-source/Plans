import 'package:saudiaaaa/core/storage/role_storage.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/domain/repositories/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  const RoleRepositoryImpl(this._storage);

  final RoleStorage _storage;

  @override
  Future<UserRole?> getSavedRole() async {
    final raw = await _storage.read();
    final role = UserRole.fromStorage(raw);

    // Devices that chose a role before the `client`/`company` → `tenant-*`
    // rename still hold the old string. Rewriting it on the first read after
    // upgrade retires the legacy form without the user noticing, and a failed
    // write is harmless — reads keep accepting both.
    if (role != null && UserRole.isLegacy(raw)) {
      await _storage.write(role.storageValue);
    }

    return role;
  }

  @override
  Future<void> saveRole(UserRole role) => _storage.write(role.storageValue);

  @override
  Future<void> clearRole() => _storage.clear();
}
