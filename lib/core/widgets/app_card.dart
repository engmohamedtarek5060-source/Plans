import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.gradient,
    this.borderColor,
    this.elevated = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? borderColor;
  final bool elevated;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = context.isDarkMode;

    final decoration = BoxDecoration(
      gradient: widget.gradient ??
          (isDark ? AppColors.surfaceGradientDark : null),
      color: widget.gradient == null && !isDark ? colors.cardBackground : null,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      border: Border.all(
        color: widget.borderColor ?? colors.cardBorder,
        width: 1,
      ),
      boxShadow: widget.elevated
          ? AppEffects.softShadow(isDark: isDark, blur: 20)
          : null,
    );

    final content = Padding(
      padding: widget.padding ?? AppSpacing.cardPadding,
      child: widget.child,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.985 : 1,
          duration: AppEffects.fast,
          curve: AppEffects.easeOut,
          child: DecoratedBox(
            decoration: decoration,
            child: content,
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: decoration,
      child: content,
    );
  }
}
