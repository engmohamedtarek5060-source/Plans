import 'package:saudiaaaa/core/storage/settings_storage.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_settings.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';
import 'package:saudiaaaa/features/settings/domain/repositories/settings_repository.dart';

/// Storage-backed settings. No data source and no model: the persisted form is
/// a single string per preference, so a mapping layer would only forward calls
/// — the same shape [RoleRepositoryImpl] takes.
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._storage);

  final SettingsStorage _storage;

  @override
  Future<AppSettings> load() async {
    // Read both at once: each carries its own timeout, and running them in
    // series would let a slow keystore charge that timeout twice against the
    // first frame.
    final stored = await Future.wait([
      _storage.readThemeMode(),
      _storage.readLanguage(),
    ]);

    // Each preference resolves on its own: a corrupted theme must not also
    // reset a perfectly good language.
    return AppSettings(
      themeMode: AppThemeMode.fromStorage(stored[0]) ??
          AppSettings.fallback.themeMode,
      language: AppLanguage.fromStorage(stored[1]) ??
          AppSettings.fallback.language,
    );
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) =>
      _storage.writeThemeMode(mode.storageValue);

  @override
  Future<void> saveLanguage(AppLanguage language) =>
      _storage.writeLanguage(language.storageValue);
}
