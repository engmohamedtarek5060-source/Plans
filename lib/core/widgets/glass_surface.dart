import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blur = AppEffects.glassBlur,
    this.showBorder = true,
    this.elevated = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double blur;
  final bool showBorder;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colors = context.appColors;
    final radius = borderRadius ?? BorderRadius.circular(AppSpacing.cardRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: AppEffects.glassFilter(sigma: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(
                    alpha: AppEffects.glassOpacityDark,
                  )
                : AppColors.lightSurface.withValues(
                    alpha: AppEffects.glassOpacityLight,
                  ),
            borderRadius: radius,
            border: showBorder
                ? Border.all(color: colors.glassBorder)
                : null,
            boxShadow: elevated
                ? AppEffects.softShadow(isDark: isDark, blur: 16)
                : null,
          ),
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
