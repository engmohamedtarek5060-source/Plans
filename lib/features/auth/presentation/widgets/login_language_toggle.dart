import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';

class LoginLanguageToggle extends ConsumerWidget {
  const LoginLanguageToggle({super.key, required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    return GlassSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      child: InkWell(
        onTap: () => ref.read(localeProvider.notifier).toggle(),
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language_rounded, size: 16, color: colors.textSecondary),
            const SizedBox(width: 6),
            Text(
              isArabic ? 'EN' : 'عربي',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: colors.textPrimary,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
