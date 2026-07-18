import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/features/auth/domain/failures/auth_failure.dart';
import 'package:saudiaaaa/features/auth/domain/usecases/login_user.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required RestoreSession restoreSession,
    required SessionEvents sessionEvents,
  })  : _loginUser = loginUser,
        _logoutUser = logoutUser,
        _restoreSession = restoreSession,
        super(const AuthInitial()) {
    // A 401 on any authenticated request, anywhere in the app, lands here.
    _unauthorizedSub = sessionEvents.onUnauthorized.listen((_) {
      _onSessionExpired();
    });
  }

  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final RestoreSession _restoreSession;
  late final StreamSubscription<void> _unauthorizedSub;

  bool get isAuthenticated => state is AuthAuthenticated;
  bool get isLoading => state is AuthLoading;

  /// How long startup will wait for the stored session before giving up.
  ///
  /// Bounded because the app shows a splash until this settles: if secure
  /// storage or the network stalls, the user must still reach a login screen
  /// rather than an endless spinner.
  static const _bootstrapTimeout = Duration(seconds: 10);

  /// Resolves any persisted session. Called once at startup; the app sits on a
  /// splash in [AuthInitial] until this settles.
  Future<void> bootstrap() async {
    try {
      final user = await _restoreSession().timeout(_bootstrapTimeout);
      emit(user == null ? const AuthUnauthenticated() : AuthAuthenticated(user));
    } catch (_) {
      // A bad stored session, a dead platform channel, or a timeout must never
      // wedge startup — fall through to login.
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = await _loginUser(email: email, password: password);
      emit(AuthAuthenticated(user));
    } on ApiException catch (e) {
      emit(AuthUnauthenticated(failure: _mapFailure(e)));
    } catch (_) {
      emit(const AuthUnauthenticated(failure: UnexpectedAuthFailure()));
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUser();
    } finally {
      // The repository clears local state regardless, so always land here.
      emit(const AuthUnauthenticated());
    }
  }

  void clearFailure() {
    if (state is AuthUnauthenticated) {
      emit(const AuthUnauthenticated());
    }
  }

  /// The token was rejected mid-session: drop to login with an explanation.
  /// Ignored when already logged out, so a burst of 401s cannot loop.
  void _onSessionExpired() {
    if (state is AuthUnauthenticated) return;
    emit(const AuthUnauthenticated(failure: SessionExpiredFailure()));
  }

  AuthFailure _mapFailure(ApiException e) => switch (e.kind) {
        // On /auth/login a 401 means the credentials are wrong, not that a
        // session expired.
        ApiErrorKind.unauthorized => const InvalidCredentialsFailure(),
        ApiErrorKind.validation ||
        ApiErrorKind.noInternet ||
        ApiErrorKind.timeout ||
        ApiErrorKind.server ||
        ApiErrorKind.badResponse =>
          NetworkAuthFailure(
            message: e.message,
            messageAr: e.messageAr ?? e.message,
          ),
        _ => const UnexpectedAuthFailure(),
      };

  @override
  Future<void> close() {
    _unauthorizedSub.cancel();
    return super.close();
  }
}
