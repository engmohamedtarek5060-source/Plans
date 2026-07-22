import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

/// A selectable role tile: icon, title, description and a check badge.
///
/// Not built on [AppCard] — that card animates its press scale only, while the
/// selected state here has to move the border, glow, surface tint and icon
/// colour together. One [TweenAnimationBuilder] drives all of them from a
/// single 0→1 value, so nothing can drift out of step the way four nested
/// implicit animations would.
class RoleOptionCard extends StatelessWidget {
  const RoleOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.selectedLabel,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;

  /// Announced by screen readers when this option is the chosen one.
  final String selectedLabel;

  /// Null disables the tile — used while a choice is being committed.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = context.isDarkMode;
    final textTheme = Theme.of(context).textTheme;

    final restingGradient =
        isDark ? AppColors.surfaceGradientDark : AppColors.surfaceGradientLight;

    // Both gradients are two-stop so the lerp between them stays stable.
    final selectedGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.brandPrimary.withValues(alpha: isDark ? 0.30 : 0.12),
        AppColors.brandPrimary.withValues(alpha: isDark ? 0.10 : 0.04),
      ],
    );

    final restingShadow = AppEffects.softShadow(isDark: isDark, blur: 20);
    final selectedShadow =
        AppEffects.glowShadow(AppColors.brandPrimary, blur: 26);

    return Semantics(
      button: true,
      selected: isSelected,
      value: isSelected ? selectedLabel : null,
      child: GestureDetector(
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: isSelected ? 1 : 0),
          duration: AppEffects.normal,
          curve: AppEffects.easeOut,
          builder: (context, t, _) {
            final accent = Color.lerp(colors.cardBorder, AppColors.brandPrimary, t)!;
            final iconColor = Color.lerp(AppColors.brandPrimary, Colors.white, t)!;

            return Transform.scale(
              // A restrained lift: enough to read as "picked" without the tile
              // jumping into its neighbour.
              scale: lerpDouble(1, 1.02, t)!,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: Gradient.lerp(restingGradient, selectedGradient, t),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: accent, width: lerpDouble(1, 2, t)!),
                  boxShadow: BoxShadow.lerpList(restingShadow, selectedShadow, t),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: t > 0 ? AppColors.brandGradient : null,
                        color: Color.lerp(
                          AppColors.brandPrimary.withValues(alpha: 0.10),
                          Colors.transparent,
                          t,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, size: 26, color: iconColor),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: textTheme.titleMedium?.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            description,
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Opacity(
                      opacity: t,
                      child: Transform.scale(
                        scale: lerpDouble(0.6, 1, t)!,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            gradient: AppColors.brandGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
