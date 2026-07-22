/// Which experience the app opens into, chosen once on first launch.
///
/// This is a device-level preference picked *before* sign-in. It is not the
/// backend's account role — that vocabulary is seven values wide
/// (`ADMIN, MANAGER, ACCOUNTANT, HR, SALES, SUPPORT, USER`), lives on the
/// authenticated user, and is modelled separately by `AccountRole`. Once a user
/// signs in, the server's role decides where they land; this only decides which
/// pre-login experience to show.
enum UserRole {
  client('tenant-user', legacyValues: {'client'}),
  company('tenant-admin', legacyValues: {'company'});

  const UserRole(this.storageValue, {required this.legacyValues});

  /// The stable key written to storage.
  ///
  /// Deliberately not `name`: renaming an enum constant is a refactor that
  /// looks safe, but it would silently invalidate the saved role of every
  /// installed user and send them all back to the selection screen.
  final String storageValue;

  /// Values this role was previously stored as.
  ///
  /// [storageValue] was renamed from `client`/`company` to the `tenant-*` form.
  /// Without this set every device that had already chosen a role would read
  /// back an unrecognised value and be sent through onboarding a second time.
  /// Reads accept these; writes always use [storageValue], so a device migrates
  /// the first time its role is re-saved.
  final Set<String> legacyValues;

  /// Parses a persisted value, tolerating null, empty, and anything written by
  /// a newer or corrupted build. An unrecognised value means "not chosen yet",
  /// so the user is asked again rather than dropped into the wrong flow.
  static UserRole? fromStorage(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final role in UserRole.values) {
      if (role.storageValue == value || role.legacyValues.contains(value)) {
        return role;
      }
    }
    return null;
  }

  /// Whether [value] is a pre-rename form that should be rewritten on read.
  static bool isLegacy(String? value) {
    if (value == null || value.isEmpty) return false;
    return UserRole.values.any((role) => role.legacyValues.contains(value));
  }
}
