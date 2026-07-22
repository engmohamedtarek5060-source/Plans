/// The signed-in account's permission level, as the backend reports it.
///
/// The exact enum `/api/users` validates against:
/// `ADMIN, MANAGER, ACCOUNTANT, HR, SALES, SUPPORT, USER`. Confirmed by
/// probing on 2026-07-21; the OpenAPI spec ships no response schemas.
///
/// Distinct from `UserRole`, which is the local pre-login choice. This one is
/// authoritative after sign-in: an account's real permissions cannot be decided
/// by what someone tapped on a selection screen.
enum AccountRole {
  admin('ADMIN'),
  manager('MANAGER'),
  accountant('ACCOUNTANT'),
  hr('HR'),
  sales('SALES'),
  support('SUPPORT'),

  /// The base role. Everyone inside a company holds one of the roles above;
  /// `USER` is the least privileged and the only one routed to the user-facing
  /// dashboard.
  user('USER');

  const AccountRole(this.apiValue);

  /// The value the backend sends and accepts.
  final String apiValue;

  /// Parses the `role` field of an authenticated user.
  ///
  /// Case-insensitive, and unknown values fall back to [user]: a role added
  /// server-side later must not strand an existing client on a blank screen,
  /// and the least-privileged destination is the safe guess.
  static AccountRole fromApi(String? value) {
    final normalized = value?.trim().toUpperCase() ?? '';
    if (normalized.isEmpty) return AccountRole.user;
    for (final role in AccountRole.values) {
      if (role.apiValue == normalized) return role;
    }
    return AccountRole.user;
  }

  /// Whether this role works *inside* the company and gets the company
  /// dashboard.
  ///
  /// Everything except [user]: a manager, accountant, HR or sales person all
  /// need the operational app, not the client-facing portal. Expressed as
  /// "not user" rather than a list so a role added to the enum defaults to the
  /// company side only if it is deliberately placed above [user].
  bool get isCompanyStaff => this != AccountRole.user;
}
