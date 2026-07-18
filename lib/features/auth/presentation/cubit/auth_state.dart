import 'package:equatable/equatable.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/domain/failures/auth_failure.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({this.failure});

  final AuthFailure? failure;

  @override
  List<Object?> get props => [failure];
}
