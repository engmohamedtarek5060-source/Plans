import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData light({required bool isArabic}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.light,
      primary: AppColors.brandPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.brandAccent,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      error: AppColors.brandError,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      isDark: false,
      isArabic: isArabic,
      extensions: const [AppColorExtension.light],
      scaffoldBackground: AppColors.lightBackground,
    );
  }

  static ThemeData dark({required bool isArabic}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.dark,
      primary: AppColors.brandPrimaryLight,
      onPrimary: Colors.white,
      secondary: AppColors.brandAccent,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      error: AppColors.brandError,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      isDark: true,
      isArabic: isArabic,
      extensions: const [AppColorExtension.dark],
      scaffoldBackground: AppColors.darkBackground,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required bool isDark,
    required bool isArabic,
    required List<ThemeExtension<dynamic>> extensions,
    required Color scaffoldBackground,
  }) {
    final textTheme = isArabic
        ? AppTypography.arabicTextTheme(isDark: isDark)
        : AppTypography.textTheme(isDark: isDark);
    final colors = isDark ? AppColorExtension.dark : AppColorExtension.light;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      textTheme: textTheme,
      extensions: extensions,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colors.textPrimary,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colors.cardBackground,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: BorderSide(color: colors.cardBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: BorderSide(color: colors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: BorderSide(color: colors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.brandPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.brandError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.brandError,
            width: 1.5,
          ),
        ),
        hintStyle: TextStyle(color: colors.textTertiary),
        errorStyle: TextStyle(
          color: colors.error,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brandPrimary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.brandPrimary;
          }
          return colors.cardBorder;
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.inputFill,
        selectedColor: AppColors.brandPrimary.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
        ),
        side: BorderSide(color: colors.cardBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.cardBorder,
        thickness: 1,
        space: 1,
      ),
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
    );
  }
}
