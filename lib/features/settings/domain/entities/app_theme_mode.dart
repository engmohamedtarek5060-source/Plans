/// The appearance the user has chosen, independent of Flutter's [ThemeMode].
///
/// Kept as its own enum so the domain owns the persisted vocabulary: the stored
/// string is a contract with every installed device, and it must not shift
/// because the framework renames or reorders its own enum.
enum AppThemeMode {
  light('light'),
  dark('dark'),

  /// Follow the operating system. This is the fallback when nothing is stored,
  /// so a fresh install matches the device rather than imposing a look.
  system('system');

  const AppThemeMode(this.storageValue);

  /// The stable key written to storage.
  ///
  /// Deliberately not `name`, for the reason spelled out on
  /// [UserRole.storageValue]: renaming a constant would silently reset the
  /// appearance of every installed user.
  final String storageValue;

  /// Parses a persisted value, tolerating null, empty, and anything written by
  /// a newer or corrupted build. Unrecognised input means "not chosen", which
  /// the caller resolves to [system] — never a guess at light or dark.
  static AppThemeMode? fromStorage(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final mode in AppThemeMode.values) {
      if (mode.storageValue == value) return mode;
    }
    return null;
  }
}
