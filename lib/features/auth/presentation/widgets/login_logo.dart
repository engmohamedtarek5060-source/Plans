import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppEffects.glowShadow(AppColors.brandPrimary),
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.25),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Image.asset(
          'assets/images/logo.jpeg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.insights_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
      ),
    );
  }
}
