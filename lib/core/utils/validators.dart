import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/utils/number_input.dart';

/// Form field validators shared across the auth screens.
///
/// Each returns null when the value is acceptable and a localized message
/// otherwise, matching the `FormFieldValidator` contract so they can be passed
/// straight to a field.
abstract final class Validators {
  /// Deliberately not a full RFC 5322 implementation — that grammar accepts
  /// addresses no login form should encourage (quoted strings, comments, bare
  /// IP literals) and is unreadable besides. This covers the shape of a real
  /// address: a local part, a domain, and at least one dot-separated label, so
  /// `@`, `a@`, and `a@b` are rejected while `name@company.com` passes.
  ///
  /// The server remains the authority on whether an address actually exists;
  /// this only stops a request that is certain to fail.
  static final RegExp _emailPattern = RegExp(
    r"^[\w.!#$%&'*+/=?^`{|}~-]+"
    r'@'
    r'[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?'
    r'(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)+$',
  );
  static final RegExp _letterPattern = RegExp(r'\p{L}', unicode: true);
  static final RegExp _numberPattern = RegExp(r'\d');

  /// Validates an email address, ignoring surrounding whitespace.
  ///
  /// Trimming here mirrors the repository, which trims before sending: a
  /// trailing space pasted in from a password manager should not read as
  /// invalid when the request would have succeeded.
  static String? email(String? value, {required bool isArabic}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return AppStrings.emailRequired(isArabic);
    if (!_emailPattern.hasMatch(trimmed)) {
      return AppStrings.emailInvalid(isArabic);
    }
    return null;
  }

  /// Presence only. No length or complexity rule: those belong to registration,
  /// and applying them at sign-in would lock out any existing account whose
  /// password predates the current policy. The server is the authority on
  /// whether an existing password is correct.
  static String? password(String? value, {required bool isArabic}) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired(isArabic);
    }
    return null;
  }

  /// The backend's floor, mirrored client-side.
  ///
  /// `/auth/register` rejects anything shorter with
  /// `password must be longer than or equal to 6 characters`. Checking here
  /// turns a round-trip and a red snackbar into inline feedback.
  static const int minPasswordLength = 6;

  /// For choosing a password, as opposed to entering an existing one. This is
  /// where the policy is enforced, so a new account cannot be created with
  /// credentials the backend would reject.
  static String? newPassword(String? value, {required bool isArabic}) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired(isArabic);
    }
    if (value.length < minPasswordLength) {
      return AppStrings.passwordTooShort(isArabic, minPasswordLength);
    }
    if (!_letterPattern.hasMatch(value) || !_numberPattern.hasMatch(value)) {
      return AppStrings.passwordNeedsLettersAndNumbers(isArabic);
    }
    return null;
  }

  /// Confirms a password by comparing against [original].
  ///
  /// Compared verbatim — no trimming — because trailing whitespace is part of
  /// a password, and silently matching two different strings would let someone
  /// register with a password they cannot reproduce.
  static String? confirmPassword(
    String? value, {
    required String original,
    required bool isArabic,
  }) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired(isArabic);
    }
    if (value != original) return AppStrings.passwordsDoNotMatch(isArabic);
    return null;
  }

  /// A required free-text field (a person's name, a company's name).
  ///
  /// No character-class rule: names legitimately contain spaces, apostrophes,
  /// hyphens, and non-Latin scripts, and this app is bilingual by default.
  static String? requiredText(
    String? value, {
    required String message,
    int minLength = 2,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.length < minLength) return message;
    return null;
  }

  /// A person's name must contain at least one letter. This accepts Arabic,
  /// Latin, and other scripts while rejecting numeric-only input.
  static String? name(String? value, {required bool isArabic}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.length < 2) return AppStrings.nameRequired(isArabic);
    if (!_letterPattern.hasMatch(trimmed)) {
      return AppStrings.nameCannotBeNumbersOnly(isArabic);
    }
    return null;
  }

  /// A money amount, parsed the same way the submit path parses it.
  ///
  /// [min] mirrors the backend's floor so the user gets inline feedback instead
  /// of a round-trip and a red snackbar — `POST /hr/expense-claims` rejects a
  /// line with `amount must not be less than 0.01`.
  static String? amount(
    String? value, {
    required String message,
    double min = 0.01,
  }) {
    final parsed = parseAmountInput(value);
    if (parsed == null || parsed < min) return message;
    return null;
  }

  /// An optional whole number: blank passes, garbage does not.
  ///
  /// Used for fields the API treats as optional (a product's reorder point),
  /// where leaving the field empty must stay valid.
  static String? optionalInteger(String? value, {required String message}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    if (parseIntInput(trimmed) == null) return message;
    return null;
  }

  /// An optional money amount: blank passes, garbage does not.
  static String? optionalAmount(String? value, {required String message}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    if (parseAmountInput(trimmed) == null) return message;
    return null;
  }
}
