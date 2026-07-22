import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/role/data/repositories/role_repository_impl.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/domain/repositories/role_repository.dart';
import 'package:saudiaaaa/features/role/domain/usecases/get_saved_role.dart';

final roleRepositoryProvider = Provider<RoleRepository>(
  (ref) => RoleRepositoryImpl(ref.watch(roleStorageProvider)),
);

final getSavedRoleProvider = Provider<GetSavedRole>(
  (ref) => GetSavedRole(ref.watch(roleRepositoryProvider)),
);

final saveRoleProvider = Provider<SaveRole>(
  (ref) => SaveRole(ref.watch(roleRepositoryProvider)),
);

final clearRoleProvider = Provider<ClearRole>(
  (ref) => ClearRole(ref.watch(roleRepositoryProvider)),
);

/// The persisted entry role for the whole app, resolved once at startup.
///
/// The three states each mean something to the root gate:
/// - `AsyncLoading` — storage hasn't answered yet; hold the splash so a
///   returning user never sees the selection screen flash past.
/// - `AsyncData(null)` — nothing chosen; show the selection screen.
/// - `AsyncData(role)` — route into that flow.
final roleControllerProvider = AsyncNotifierProvider<RoleController, UserRole?>(
  RoleController.new,
);

class RoleController extends AsyncNotifier<UserRole?> {
  @override
  Future<UserRole?> build() => ref.read(getSavedRoleProvider)();

  /// Persists [role] and switches the app into that flow.
  ///
  /// State is published only after the write completes, so the root gate never
  /// routes on a choice that is still mid-flight.
  Future<void> setRole(UserRole role) async {
    await ref.read(saveRoleProvider)(role);
    state = AsyncData(role);
  }

  /// Forgets the choice and returns the app to the selection screen.
  Future<void> clear() async {
    await ref.read(clearRoleProvider)();
    state = const AsyncData(null);
  }
}
