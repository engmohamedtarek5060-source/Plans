import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';

/// Persistence for the entry role chosen on first launch.
abstract class RoleRepository {
  /// The saved role, or null when nothing valid is stored — first launch, a
  /// cleared role, or unreadable storage.
  Future<UserRole?> getSavedRole();

  Future<void> saveRole(UserRole role);

  /// Forgets the choice, so the next launch shows the selection screen again.
  Future<void> clearRole();
}
