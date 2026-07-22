import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_settings.dart';
import 'package:saudiaaaa/features/settings/domain/repositories/settings_repository.dart';
import 'package:saudiaaaa/features/settings/domain/usecases/load_settings.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(ref.watch(settingsStorageProvider)),
);

final loadSettingsProvider = Provider<LoadSettings>(
  (ref) => LoadSettings(ref.watch(settingsRepositoryProvider)),
);

final saveThemeModeProvider = Provider<SaveThemeMode>(
  (ref) => SaveThemeMode(ref.watch(settingsRepositoryProvider)),
);

final saveLanguageProvider = Provider<SaveLanguage>(
  (ref) => SaveLanguage(ref.watch(settingsRepositoryProvider)),
);

/// The preferences resolved in `main` before `runApp`, seeding the theme and
/// locale notifiers with their starting state.
///
/// Unlike [apiServiceProvider] and friends this has a real default rather than
/// throwing when unoverridden. "Nothing was loaded" is a legitimate state with
/// one correct answer — [AppSettings.fallback] — so a test that does not care
/// about persistence gets the same behaviour the app had before it existed.
final bootstrapSettingsProvider = Provider<AppSettings>(
  (ref) => AppSettings.fallback,
);
