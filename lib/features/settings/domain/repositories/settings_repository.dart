import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_settings.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';

/// Reads and writes the device-level appearance and language preferences.
abstract class SettingsRepository {
  /// Never throws and never returns null: unreadable or absent storage
  /// resolves to [AppSettings.fallback], because this gates the first frame.
  Future<AppSettings> load();

  Future<void> saveThemeMode(AppThemeMode mode);

  Future<void> saveLanguage(AppLanguage language);
}
