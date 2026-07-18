import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

enum ButtonVariant { primary, secondary, ghost, danger }

enum ButtonSize { sm, md, lg }

class CustomPrimaryButton extends StatefulWidget {
  const CustomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isExpanded = true,
    this.variant = ButtonVariant.primary,
    this.useGradient = false,
    this.size = ButtonSize.md,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;
  final ButtonVariant variant;
  final bool useGradient;
  final ButtonSize size;

  @override
  State<CustomPrimaryButton> createState() => _CustomPrimaryButtonState();
}

class _CustomPrimaryButtonState extends State<CustomPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1,
    );
    _scale = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets _padding() => switch (widget.size) {
        ButtonSize.sm => const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs + 2,
          ),
        ButtonSize.md => const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm + 4,
          ),
        ButtonSize.lg => const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
      };

  double _fontSize() => switch (widget.size) {
        ButtonSize.sm => 13,
        ButtonSize.md => 15,
        ButtonSize.lg => 16,
      };

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors(context);
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    final decoration = widget.useGradient &&
            widget.variant == ButtonVariant.primary
        ? BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            boxShadow: isEnabled
                ? AppEffects.glowShadow(AppColors.brandPrimary, blur: 20)
                : null,
          )
        : BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            border: colors.border != null
                ? Border.all(color: colors.border!)
                : null,
            boxShadow: widget.variant == ButtonVariant.primary && isEnabled
                ? AppEffects.softShadow(
                    isDark: context.isDarkMode,
                    blur: 12,
                  )
                : null,
          );

    final child = AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          onTapDown: isEnabled ? (_) {
            HapticFeedback.lightImpact();
            _controller.reverse();
          } : null,
          onTapUp: isEnabled ? (_) => _controller.forward() : null,
          onTapCancel: isEnabled ? () => _controller.forward() : null,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          splashColor: colors.foreground.withValues(alpha: 0.08),
          highlightColor: colors.foreground.withValues(alpha: 0.04),
          child: AnimatedOpacity(
            opacity: isEnabled ? 1 : 0.55,
            duration: AppEffects.fast,
            child: Container(
              padding: _padding(),
              decoration: decoration,
              child: widget.isLoading
                  ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: colors.foreground,
                      ),
                    )
                  : Row(
                      mainAxisSize: widget.isExpanded
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: widget.size == ButtonSize.sm ? 18 : 20,
                            color: colors.foreground,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                        ],
                        Text(
                          widget.label,
                          style: TextStyle(
                            color: colors.foreground,
                            fontWeight: FontWeight.w600,
                            fontSize: _fontSize(),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

    return widget.isExpanded
        ? SizedBox(width: double.infinity, child: child)
        : child;
  }

  _ButtonColors _resolveColors(BuildContext context) {
    final isDark = context.isDarkMode;
    return switch (widget.variant) {
      ButtonVariant.primary => _ButtonColors(
          background: AppColors.brandPrimary,
          foreground: Colors.white,
        ),
      ButtonVariant.secondary => _ButtonColors(
          background: isDark
              ? AppColors.darkSurfaceElevated
              : AppColors.lightSurfaceElevated,
          foreground: context.appColors.textPrimary,
          border: context.appColors.cardBorder,
        ),
      ButtonVariant.ghost => _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.brandPrimary,
          border: context.appColors.cardBorder,
        ),
      ButtonVariant.danger => _ButtonColors(
          background: AppColors.brandError,
          foreground: Colors.white,
        ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
