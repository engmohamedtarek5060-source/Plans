import 'package:equatable/equatable.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';

/// The device-level preferences resolved once, before the first frame.
///
/// Theme and language travel together because they are read together: the app
/// cannot build its first `MaterialApp` until both are known, and two separate
/// async loads would mean two chances to paint the wrong thing.
class AppSettings extends Equatable {
  const AppSettings({required this.themeMode, required this.language});

  /// What a device with nothing stored gets: the system appearance, and Arabic
  /// — the app's primary language, matching the pre-persistence default so an
  /// existing install sees no change on upgrade.
  static const fallback = AppSettings(
    themeMode: AppThemeMode.system,
    language: AppLanguage.arabic,
  );

  final AppThemeMode themeMode;
  final AppLanguage language;

  AppSettings copyWith({AppThemeMode? themeMode, AppLanguage? language}) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
      );

  @override
  List<Object?> get props => [themeMode, language];
}
