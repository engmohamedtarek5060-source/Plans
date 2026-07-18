import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final displayLabel = count != null ? '$label ($count)' : label;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppEffects.normal,
        curve: AppEffects.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.brandGradient : null,
          color: isSelected ? null : colors.inputFill,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : colors.cardBorder,
          ),
          boxShadow: isSelected
              ? AppEffects.glowShadow(
                  AppColors.brandPrimary,
                  blur: 12,
                )
              : null,
        ),
        child: Text(
          displayLabel,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
            color: isSelected ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
