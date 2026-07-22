/// The language the app renders in, and with it the reading direction.
///
/// The storage value is an ISO 639-1 code so it lines up with the `Locale`
/// built from it in the presentation layer, but the domain does not depend on
/// Flutter to say which languages exist.
enum AppLanguage {
  arabic('ar', isRtl: true),
  english('en', isRtl: false);

  const AppLanguage(this.storageValue, {required this.isRtl});

  /// The stable key written to storage, and the locale's language code.
  final String storageValue;

  /// Whether the language reads right-to-left. Belongs to the language itself,
  /// not to the widget tree, so nothing has to re-derive it from a string
  /// comparison at each call site.
  final bool isRtl;

  /// Parses a persisted value, tolerating null, empty, and unsupported codes.
  /// Anything unrecognised means "not chosen", so the caller falls back rather
  /// than launching into a language the app has no strings for.
  static AppLanguage? fromStorage(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final language in AppLanguage.values) {
      if (language.storageValue == value) return language;
    }
    return null;
  }

  /// The other supported language, for the single-tap toggle in settings.
  AppLanguage get opposite => this == arabic ? english : arabic;
}
