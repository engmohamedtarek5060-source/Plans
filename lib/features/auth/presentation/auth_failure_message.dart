import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/features/auth/domain/failures/auth_failure.dart';

/// Localized copy for every [AuthFailure].
///
/// Shared by the login and register screens so a new failure variant cannot be
/// handled in one and forgotten in the other — the switch is exhaustive over a
/// sealed class, so adding a variant breaks the build here rather than silently
/// showing a generic message.
extension AuthFailureMessage on AuthFailure {
  String localized(bool isArabic) => switch (this) {
        InvalidCredentialsFailure() => AppStrings.invalidCredentials(isArabic),
        EmailAlreadyRegisteredFailure() =>
          AppStrings.emailAlreadyRegistered(isArabic),
        // Carries a specific cause (offline, timeout, server error) — showing
        // it beats a generic "something went wrong".
        NetworkAuthFailure(:final localized) => localized(isArabic),
        SessionExpiredFailure() => AppStrings.sessionExpired(isArabic),
        UnexpectedAuthFailure() => AppStrings.errorTitle(isArabic),
      };
}
