import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/shell/presentation/screens/main_shell_screen.dart';

/// Root gate: splash while the stored session resolves, then login or the app.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

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
          child: switch (state) {
            AuthAuthenticated() => const MainShellScreen(key: ValueKey('main')),
            // Startup: hold a splash until the stored token is checked, so a
            // returning user never sees the login screen flash past.
            AuthInitial() => const _SplashScreen(key: ValueKey('splash')),
            _ => const LoginScreen(key: ValueKey('login')),
          },
        );
      },
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
