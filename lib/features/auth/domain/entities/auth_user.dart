import 'package:equatable/equatable.dart';

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

  /// Backend role, e.g. `ADMIN`.
  final String role;

  final AuthCompany? company;

  @override
  List<Object?> get props => [id, email, fullName, fullNameAr, role, company];
}
