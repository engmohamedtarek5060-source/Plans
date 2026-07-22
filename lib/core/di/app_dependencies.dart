import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/core/storage/role_storage.dart';
import 'package:saudiaaaa/core/storage/settings_storage.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
export 'package:saudiaaaa/core/storage/token_storage.dart'
    show SecureKeyValueStore;

/// Composition root.
///
/// The app runs Riverpod (feature data) and Bloc (auth) side by side; both must
/// share one [ApiService] so a single token and a single 401 channel govern
/// every request. These are built once in `main` and injected into each.
class AppDependencies {
  AppDependencies._({
    required this.tokenStorage,
    required this.roleStorage,
    required this.settingsStorage,
    required this.sessionEvents,
    required this.apiService,
  });

  final TokenStorage tokenStorage;
  final RoleStorage roleStorage;
  final SettingsStorage settingsStorage;
  final SessionEvents sessionEvents;
  final ApiService apiService;

  /// [store] overrides where the session is persisted. Tests pass an in-memory
  /// store because platform secure storage has no implementation under
  /// `flutter test`.
  factory AppDependencies.create({SecureKeyValueStore? store}) {
    final tokenStorage = TokenStorage(store: store);
    final sessionEvents = SessionEvents();
    return AppDependencies._(
      tokenStorage: tokenStorage,
      roleStorage: RoleStorage(store: store),
      settingsStorage: SettingsStorage(store: store),
      sessionEvents: sessionEvents,
      apiService: ApiService(
        tokenStorage: tokenStorage,
        sessionEvents: sessionEvents,
      ),
    );
  }
}

/// Overridden in `main` with the instance from [AppDependencies].
final apiServiceProvider = Provider<ApiService>(
  (ref) => throw UnimplementedError(
    'apiServiceProvider must be overridden in ProviderScope',
  ),
);

/// Overridden in `main` with the instance from [AppDependencies], so the role
/// and the session share one underlying store.
final roleStorageProvider = Provider<RoleStorage>(
  (ref) => throw UnimplementedError(
    'roleStorageProvider must be overridden in ProviderScope',
  ),
);

/// Overridden in `main` with the instance from [AppDependencies], so the theme
/// and language preferences share the store the session and role already use.
final settingsStorageProvider = Provider<SettingsStorage>(
  (ref) => throw UnimplementedError(
    'settingsStorageProvider must be overridden in ProviderScope',
  ),
);

/// The signed-in user's currency (e.g. `SAR`), for money formatting.
/// Defaults to SAR until the session resolves.
final currencyProvider = StateProvider<String>((ref) => 'SAR');
