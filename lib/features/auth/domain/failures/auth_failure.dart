import 'package:equatable/equatable.dart';

sealed class AuthFailure extends Equatable {
  const AuthFailure();

  @override
  List<Object?> get props => [];
}

/// The backend rejected the email/password pair (401 on /auth/login).
final class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure();
}

/// The request never produced a usable answer — offline, timeout, server
/// error, or a malformed response. Carries a ready-to-show message so the UI
/// can tell "no internet" apart from "the server is down".
final class NetworkAuthFailure extends AuthFailure {
  const NetworkAuthFailure({required this.message, required this.messageAr});

  final String message;
  final String messageAr;

  String localized(bool isArabic) => isArabic ? messageAr : message;

  @override
  List<Object?> get props => [message, messageAr];
}

/// The email is already taken (409 on /auth/register). Actionable in a way the
/// generic failures are not — the user should sign in instead of retrying.
final class EmailAlreadyRegisteredFailure extends AuthFailure {
  const EmailAlreadyRegisteredFailure();
}

/// The session ended server-side (a 401 on any authenticated call).
final class SessionExpiredFailure extends AuthFailure {
  const SessionExpiredFailure();
}

final class UnexpectedAuthFailure extends AuthFailure {
  const UnexpectedAuthFailure();
}
