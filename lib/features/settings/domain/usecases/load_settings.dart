import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_settings.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';
import 'package:saudiaaaa/features/settings/domain/repositories/settings_repository.dart';

/// Resolves the stored preferences, falling back to [AppSettings.fallback].
///
/// Called once from `main` before `runApp`, so the first `MaterialApp` is built
/// with the user's real theme and language instead of flashing the defaults.
class LoadSettings {
  const LoadSettings(this._repository);

  final SettingsRepository _repository;

  Future<AppSettings> call() => _repository.load();
}

/// Persists a new appearance. Fire-and-forget: the choice already applies to
/// this run, so a storage failure costs the next cold start, not this one.
class SaveThemeMode {
  const SaveThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppThemeMode mode) => _repository.saveThemeMode(mode);
}

/// Persists a new language, with the same fire-and-forget contract as
/// [SaveThemeMode].
class SaveLanguage {
  const SaveLanguage(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppLanguage language) =>
      _repository.saveLanguage(language);
}
