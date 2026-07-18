import 'package:flutter/material.dart';

/// Premium semantic color tokens — Electric Violet + Emerald accents.
abstract final class AppColors {
  // Brand
  static const Color brandPrimary = Color(0xFF7C3AED);
  static const Color brandPrimaryLight = Color(0xFFA78BFA);
  static const Color brandPrimaryDark = Color(0xFF5B21B6);
  static const Color brandAccent = Color(0xFF10B981);
  static const Color brandAccentDark = Color(0xFF059669);
  static const Color brandWarning = Color(0xFFF59E0B);
  static const Color brandError = Color(0xFFEF4444);

  // Light palette
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF4F4F5);
  static const Color lightBorder = Color(0xFFE4E4E7);
  static const Color lightTextPrimary = Color(0xFF09090B);
  static const Color lightTextSecondary = Color(0xFF71717A);
  static const Color lightTextTertiary = Color(0xFFA1A1AA);

  // Dark palette
  static const Color darkBackground = Color(0xFF09090B);
  static const Color darkSurface = Color(0xFF18181B);
  static const Color darkSurfaceElevated = Color(0xFF27272A);
  static const Color darkBorder = Color(0xFF3F3F46);
  static const Color darkTextPrimary = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFA1A1AA);
  static const Color darkTextTertiary = Color(0xFF71717A);

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandPrimaryLight, brandPrimary, brandPrimaryDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandAccent, brandAccentDark],
  );

  static const LinearGradient surfaceGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF4F4F5)],
  );

  static const LinearGradient surfaceGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF27272A), Color(0xFF18181B)],
  );
}

/// Theme extension for custom semantic colors beyond Material ColorScheme.
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    required this.cardBackground,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.success,
    required this.warning,
    required this.error,
    required this.kpiRevenue,
    required this.kpiExpense,
    required this.kpiBalance,
    required this.shadow,
    required this.inputFill,
    required this.glassBorder,
  });

  final Color cardBackground;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color success;
  final Color warning;
  final Color error;
  final Color kpiRevenue;
  final Color kpiExpense;
  final Color kpiBalance;
  final Color shadow;
  final Color inputFill;
  final Color glassBorder;

  static const light = AppColorExtension(
    cardBackground: AppColors.lightSurface,
    cardBorder: AppColors.lightBorder,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    success: AppColors.brandAccent,
    warning: AppColors.brandWarning,
    error: AppColors.brandError,
    kpiRevenue: Color(0xFF7C3AED),
    kpiExpense: Color(0xFFF59E0B),
    kpiBalance: Color(0xFF10B981),
    shadow: Color(0x1409090B),
    inputFill: Color(0xFFF4F4F5),
    glassBorder: Color(0x66FFFFFF),
  );

  static const dark = AppColorExtension(
    cardBackground: AppColors.darkSurface,
    cardBorder: AppColors.darkBorder,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    success: AppColors.brandAccent,
    warning: AppColors.brandWarning,
    error: AppColors.brandError,
    kpiRevenue: Color(0xFFA78BFA),
    kpiExpense: Color(0xFFFBBF24),
    kpiBalance: Color(0xFF34D399),
    shadow: Color(0x50000000),
    inputFill: AppColors.darkSurfaceElevated,
    glassBorder: Color(0x14FFFFFF),
  );

  @override
  AppColorExtension copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? success,
    Color? warning,
    Color? error,
    Color? kpiRevenue,
    Color? kpiExpense,
    Color? kpiBalance,
    Color? shadow,
    Color? inputFill,
    Color? glassBorder,
  }) {
    return AppColorExtension(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      kpiRevenue: kpiRevenue ?? this.kpiRevenue,
      kpiExpense: kpiExpense ?? this.kpiExpense,
      kpiBalance: kpiBalance ?? this.kpiBalance,
      shadow: shadow ?? this.shadow,
      inputFill: inputFill ?? this.inputFill,
      glassBorder: glassBorder ?? this.glassBorder,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;
    return AppColorExtension(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      kpiRevenue: Color.lerp(kpiRevenue, other.kpiRevenue, t)!,
      kpiExpense: Color.lerp(kpiExpense, other.kpiExpense, t)!,
      kpiBalance: Color.lerp(kpiBalance, other.kpiBalance, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColorExtension get appColors =>
      Theme.of(this).extension<AppColorExtension>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
