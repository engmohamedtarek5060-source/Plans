import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/splash_screen.dart';
import 'package:saudiaaaa/features/client/presentation/screens/client_home_screen.dart';
import 'package:saudiaaaa/features/company/presentation/screens/company_dashboard_screen.dart';

/// Root gate after the branded splash: session restore, then login or home.
///
/// Destination after sign-in comes from the account's server role
/// ([AuthUser.accountRole]), not from a pre-login client/company choice.
class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({super.key});

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {
  /// Minimum time the intro motion stays on screen before the gate can take over.
  static const _minSplash = Duration(milliseconds: 2800);

  bool _introDone = false;
  Timer? _introTimer;

  @override
  void initState() {
    super.initState();
    _introTimer = Timer(_minSplash, () {
      if (mounted) setState(() => _introDone = true);
    });
  }

  @override
  void dispose() {
    _introTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RootTransition(
      child: !_introDone
          ? const SplashScreen(key: ValueKey('splash-intro'))
          : const _AuthGate(key: ValueKey('auth')),
    );
  }
}

/// Session gate: splash while restoring, login when signed out, home when in.
class _AuthGate extends StatelessWidget {
  const _AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      // AuthLoading is deliberately excluded: the login/register screens own
      // that state via their button spinners, and swapping the tree under a
      // pushed register route would drop what the user typed.
      buildWhen: (prev, next) =>
          next is AuthAuthenticated ||
          next is AuthUnauthenticated ||
          next is AuthInitial,
      builder: (context, state) {
        return _RootTransition(
          child: switch (state) {
            AuthAuthenticated(:final user) => _destinationFor(user),
            // Startup: hold a splash until the stored token is checked, so a
            // returning user never sees the login screen flash past.
            AuthInitial() => const SplashScreen(key: ValueKey('splash')),
            // AuthLoading and AuthUnauthenticated both keep the login scaffold
            // mounted so a pushed RegisterScreen stays in the same navigator
            // stack and can pop back into the home shell on success.
            _ => const LoginScreen(key: ValueKey('login')),
          },
        );
      },
    );
  }

  /// Company staff land in the ERP shell; everyone else in the client portal.
  Widget _destinationFor(AuthUser user) => user.accountRole.isCompanyStaff
      ? const CompanyDashboardScreen(key: ValueKey('company'))
      : const ClientHomeScreen(key: ValueKey('client'));
}

/// The cross-fade every root-level screen swap uses.
class _RootTransition extends StatelessWidget {
  const _RootTransition({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.02),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
