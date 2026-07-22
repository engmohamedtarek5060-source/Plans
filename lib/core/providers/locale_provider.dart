import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/features/settings/domain/entities/app_language.dart';
import 'package:saudiaaaa/features/settings/domain/usecases/load_settings.dart';
import 'package:saudiaaaa/features/settings/presentation/controllers/settings_controller.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(
    // Resolved before the first frame, so the app opens in the stored language
    // and reading direction rather than flipping after the first paint.
    initial: ref.watch(bootstrapSettingsProvider).language,
    save: ref.watch(saveLanguageProvider),
  ),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier({required AppLanguage initial, required SaveLanguage save})
      : _save = save,
        _language = initial,
        super(initial.locale);

  final SaveLanguage _save;

  /// The domain value behind [state]. Held rather than re-parsed from the
  /// locale on every read, since the whole UI asks for [isArabic] each build.
  AppLanguage _language;

  AppLanguage get language => _language;

  bool get isArabic => _language == AppLanguage.arabic;

  /// The reading direction for the active language, so `Directionality` has one
  /// source of truth instead of each caller comparing language codes.
  TextDirection get textDirection =>
      _language.isRtl ? TextDirection.rtl : TextDirection.ltr;

  void setLocale(Locale locale) {
    // An unsupported code is ignored rather than applied: the app has no
    // strings for it, and switching would leave the UI in a language it cannot
    // render. Falling back silently to the current language is the safe move.
    final language = AppLanguage.fromStorage(locale.languageCode);
    if (language == null) return;
    setLanguage(language);
  }

  void setLanguage(AppLanguage language) {
    if (language == _language) return;
    _language = language;
    // Every screen reads `isArabic` off this notifier, so this one assignment
    // rebuilds the whole tree — including the `Directionality` in `app.dart`.
    state = language.locale;
    unawaited(_save(language));
  }

  void toggle() => setLanguage(_language.opposite);
}

/// Mapping to Flutter's [Locale], kept in the presentation layer so the domain
/// stays free of the framework.
extension on AppLanguage {
  Locale get locale => Locale(storageValue);
}
