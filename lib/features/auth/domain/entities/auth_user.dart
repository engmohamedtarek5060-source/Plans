import 'package:equatable/equatable.dart';
import 'package:saudiaaaa/features/auth/domain/entities/account_role.dart';

/// The company (tenant) the signed-in user belongs to.
class AuthCompany extends Equatable {
  const AuthCompany({
    required this.id,
    required this.name,
    required this.currency,
  });

  final int id;
  final String name;

  /// ISO currency code, e.g. `SAR`.
  final String currency;

  @override
  List<Object?> get props => [id, name, currency];
}

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.fullNameAr,
    required this.role,
    this.company,
  });

  final String id;
  final String email;
  final String fullName;

  /// The backend stores a single `name` per user with no Arabic variant, so
  /// this mirrors [fullName] for real accounts.
  final String fullNameAr;

  /// Backend role, e.g. `ADMIN`. Kept as the raw string so an unrecognised
  /// value survives a round trip through storage; parse it via [accountRole].
  final String role;

  final AuthCompany? company;

  /// [role] parsed into the backend's role enum.
  ///
  /// Authoritative for routing after sign-in: the local `UserRole` is only a
  /// pre-login guess, and an account's real permissions come from the server.
  AccountRole get accountRole => AccountRole.fromApi(role);

  @override
  List<Object?> get props => [id, email, fullName, fullNameAr, role, company];
}
