import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';

/// Text field with floating label, focus animation, and clear error states.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autofocus;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = context.isDarkMode;
    final hasLabel = widget.label != null && widget.label!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: AppEffects.normal,
          curve: AppEffects.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
            boxShadow: _hasFocus
                ? [
                    BoxShadow(
                      color: AppColors.brandPrimary.withValues(alpha: 0.15),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            autofocus: widget.autofocus,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              labelText: hasLabel ? widget.label : null,
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(
                color: _hasFocus
                    ? AppColors.brandPrimary
                    : colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? AnimatedContainer(
                      duration: AppEffects.fast,
                      child: Icon(
                        widget.prefixIcon,
                        size: 20,
                        color: _hasFocus
                            ? AppColors.brandPrimary
                            : colors.textTertiary,
                      ),
                    )
                  : null,
              suffixIcon: widget.suffixIcon,
              fillColor: isDark
                  ? colors.inputFill
                  : (_hasFocus
                      ? Colors.white
                      : colors.inputFill),
            ),
          ),
        ),
      ],
    );
  }
}
