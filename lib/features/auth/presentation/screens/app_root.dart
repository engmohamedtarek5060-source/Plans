import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/client/presentation/screens/client_home_screen.dart';
import 'package:saudiaaaa/features/company/presentation/screens/company_dashboard_screen.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/presentation/controllers/role_controller.dart';
import 'package:saudiaaaa/features/role/presentation/screens/role_selection_screen.dart';

/// Root gate, in two stages.
///
/// First the persisted entry role: unresolved holds a splash, absent shows the
/// selection screen. Only once a role exists does the auth gate run — role is a
/// device preference chosen before any account, so it outranks the session.
class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleControllerProvider);

    return _RootTransition(
      child: switch (role) {
        // Storage hasn't answered yet — same reasoning as the session splash
        // below: never let a first frame flash a screen the user will not stay
        // on.
        AsyncLoading() => const _SplashScreen(key: ValueKey('splash-role')),
        AsyncData(value: final chosen?) =>
          _AuthGate(role: chosen, key: const ValueKey('auth')),
        // No role stored, or the read failed. Both mean "ask": a failed read is
        // recoverable by choosing again, and guessing a flow is not.
        _ => const RoleSelectionScreen(key: ValueKey('role')),
      },
    );
  }
}

/// Session gate for a user whose role is already known.
class _AuthGate extends StatelessWidget {
  const _AuthGate({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      // AuthLoading is deliberately excluded: the login screen owns that state
      // via its own button spinner, and swapping the tree under it would drop
      // what the user typed.
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
            AuthInitial() => const _SplashScreen(key: ValueKey('splash')),
            _ => LoginScreen(role: role, key: const ValueKey('login')),
          },
        );
      },
    );
  }

  /// Where an authenticated user lands.
  ///
  /// Decided by the account's role on the server, not by [role] — that is a
  /// pre-login tap on a selection screen, and it can disagree with the account
  /// actually signed in. An ADMIN who tapped "Client" belongs in the company
  /// dashboard; sending them to the client portal would show them a scaffold
  /// with none of their data.
  Widget _destinationFor(AuthUser user) => user.accountRole.isCompanyStaff
      ? const CompanyDashboardScreen(key: ValueKey('company'))
      : const ClientHomeScreen(key: ValueKey('client'));
}

/// The cross-fade every root-level screen swap uses, so the role gate and the
/// session gate feel like one transition rather than two.
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

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PremiumBackground(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }
}
