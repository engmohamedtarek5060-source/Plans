import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar'));

  bool get isArabic => state.languageCode == 'ar';

  void setLocale(Locale locale) => state = locale;

  void toggle() {
    state = isArabic ? const Locale('en') : const Locale('ar');
  }
}
