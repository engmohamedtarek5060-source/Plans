import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_theme_mode.dart';
import 'package:saudiaaaa/features/settings/domain/usecases/load_settings.dart';
import 'package:saudiaaaa/features/settings/presentation/controllers/settings_controller.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(
    // Already resolved before the first frame, so `MaterialApp` builds with the
    // stored appearance instead of painting the default and correcting itself.
    initial: ref.watch(bootstrapSettingsProvider).themeMode,
    save: ref.watch(saveThemeModeProvider),
  ),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier({
    required AppThemeMode initial,
    required SaveThemeMode save,
  })  : _save = save,
        super(initial.materialMode);

  final SaveThemeMode _save;

  void setThemeMode(ThemeMode mode) {
    if (state == mode) return;
    state = mode;
    _persist(mode);
  }

  void toggle() {
    setThemeMode(switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      // From "follow the system" a tap means "I want the other one" — and the
      // toggle in settings is only shown for dark, so this lands on dark.
      ThemeMode.system => ThemeMode.dark,
    });
  }

  /// Unawaited: the new theme is already on screen, and the use case swallows
  /// storage failures. Waiting would only delay the repaint.
  void _persist(ThemeMode mode) {
    unawaited(_save(mode.appThemeMode));
  }
}

/// Mapping between the domain enum and Flutter's, kept in the presentation
/// layer so the domain stays free of the framework.
extension on AppThemeMode {
  ThemeMode get materialMode => switch (this) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };
}

extension on ThemeMode {
  AppThemeMode get appThemeMode => switch (this) {
        ThemeMode.light => AppThemeMode.light,
        ThemeMode.dark => AppThemeMode.dark,
        ThemeMode.system => AppThemeMode.system,
      };
}
