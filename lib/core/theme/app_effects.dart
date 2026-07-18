import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';

/// Premium visual effects — shadows, glass, gradients.
abstract final class AppEffects {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;

  static List<BoxShadow> softShadow({required bool isDark, double blur = 24}) {
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.5)
            : AppColors.lightTextPrimary.withValues(alpha: 0.06),
        blurRadius: blur,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.25)
            : AppColors.lightTextPrimary.withValues(alpha: 0.03),
        blurRadius: blur / 2,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> glowShadow(Color color, {double blur = 32}) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.4),
        blurRadius: blur,
        spreadRadius: -6,
        offset: const Offset(0, 10),
      ),
    ];
  }

  static const double glassBlur = 24;
  static const double glassOpacityLight = 0.78;
  static const double glassOpacityDark = 0.6;

  static ImageFilter glassFilter({double sigma = glassBlur}) {
    return ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
  }

  static LinearGradient meshGradient({required bool isDark}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
              AppColors.darkBackground,
              const Color(0xFF0F0A1A),
              AppColors.darkSurface,
            ]
          : [
              const Color(0xFFFAFAFA),
              const Color(0xFFF5F3FF),
              const Color(0xFFF4F4F5),
            ],
      stops: const [0.0, 0.45, 1.0],
    );
  }

  static List<RadialGradient> ambientOrbs({required bool isDark}) {
    return [
      RadialGradient(
        colors: [
          AppColors.brandPrimary.withValues(alpha: isDark ? 0.2 : 0.14),
          Colors.transparent,
        ],
        radius: 0.75,
      ),
      RadialGradient(
        colors: [
          AppColors.brandAccent.withValues(alpha: isDark ? 0.12 : 0.08),
          Colors.transparent,
        ],
        radius: 0.65,
      ),
    ];
  }
}
