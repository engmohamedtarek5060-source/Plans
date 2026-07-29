import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/theme/theme_provider.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/section_header.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/expenses/presentation/screens/expenses_screen.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;
    final themeMode = ref.watch(themeModeProvider);

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: AppSpacing.screenPadding,
      children: [
        ScreenHeader(
          title: AppStrings.settings(isArabic),
          subtitle: isArabic ? 'تخصيص التطبيق' : 'Customize your experience',
        ),
        const SizedBox(height: AppSpacing.lg),
        const _ProfileCard(),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: AppStrings.theme(isArabic)),
        _SettingsTile(
          icon: Icons.dark_mode_outlined,
          title: AppStrings.darkMode(isArabic),
          trailing: Switch.adaptive(
            value:
                themeMode == ThemeMode.dark ||
                (themeMode == ThemeMode.system &&
                    MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark),
            onChanged: (isDark) => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light),
          ),
        ),
        _SettingsTile(
          icon: Icons.brightness_auto_outlined,
          title: AppStrings.systemMode(isArabic),
          onTap: () => ref
              .read(themeModeProvider.notifier)
              .setThemeMode(ThemeMode.system),
          trailing: Icon(
            themeMode == ThemeMode.system
                ? Icons.check_circle_rounded
                : Icons.circle_outlined,
            color: themeMode == ThemeMode.system
                ? AppColors.brandPrimary
                : colors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: AppStrings.language(isArabic)),
        _SettingsTile(
          icon: Icons.language_rounded,
          title: isArabic ? 'العربية' : 'English',
          subtitle: isArabic ? 'English' : 'العربية',
          onTap: () => ref.read(localeProvider.notifier).toggle(),
          trailing: Icon(
            Icons.swap_horiz_rounded,
            color: AppColors.brandPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: isArabic ? 'العمليات' : 'Operations'),
        _SettingsTile(
          icon: Icons.receipt_long_outlined,
          title: AppStrings.expensesTitle(isArabic),
          subtitle: AppStrings.viewAll(isArabic),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const ExpensesScreen()),
          ),
        ),
        _SettingsTile(
          icon: Icons.bar_chart_rounded,
          title: isArabic ? 'التقارير' : 'Reports',
          subtitle: isArabic ? 'قريباً' : 'Coming soon',
          onTap: null,
          enabled: false,
        ),
        _SettingsTile(
          icon: Icons.checklist_rounded,
          title: isArabic ? 'الموافقات' : 'Approvals',
          subtitle: isArabic ? 'قريباً' : 'Coming soon',
          onTap: null,
          enabled: false,
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: AppStrings.logout(isArabic)),
        _SettingsTile(
          icon: Icons.logout_rounded,
          title: AppStrings.logout(isArabic),
          subtitle: isArabic ? 'العودة لصفحة الدخول' : 'Return to sign in',
          onTap: () => context.read<AuthCubit>().logout(),
          isDestructive: true,
          trailing: Icon(Icons.chevron_right_rounded, color: colors.error),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppCard(
          gradient: AppColors.brandGradient,
          borderColor: AppColors.brandPrimary.withValues(alpha: 0.3),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                ),
                child: const Icon(Icons.verified_rounded, color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Plans ERP',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      isArabic ? 'الخطة المتقدمة · نشط' : 'Advanced · Active',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                Formatters.currency(299, locale: isArabic ? 'ar' : 'en'),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

/// The signed-in account, straight from the auth session.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = context.watch<AuthCubit>().state;

    // Only reachable while authenticated, but stay defensive: a forced logout
    // can rebuild this frame before the shell is swapped out.
    if (state is! AuthAuthenticated) return const SizedBox.shrink();
    final user = state.user;

    final initial =
        user.fullName.trim().isEmpty ? '?' : user.fullName.trim()[0].toUpperCase();

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: colors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (user.company != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    user.company!.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: colors.textTertiary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (user.role.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.brandPrimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
              ),
              child: Text(
                user.role,
                style: const TextStyle(
                  color: AppColors.brandPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatefulWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool enabled;

  @override
  State<_SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<_SettingsTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final iconColor = widget.isDestructive
        ? colors.error
        : AppColors.brandPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: GestureDetector(
        onTapDown: widget.onTap != null
            ? (_) => setState(() => _pressed = true)
            : null,
        onTapUp: widget.onTap != null
            ? (_) => setState(() => _pressed = false)
            : null,
        onTapCancel: widget.onTap != null
            ? () => setState(() => _pressed = false)
            : null,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.985 : 1,
          duration: AppEffects.fast,
          curve: AppEffects.easeOut,
          child: Opacity(
            opacity: widget.enabled ? 1 : 0.5,
            child: AppCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm + 2,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          iconColor.withValues(alpha: 0.18),
                          iconColor.withValues(alpha: 0.06),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: iconColor, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: widget.isDestructive
                                    ? colors.error
                                    : colors.textPrimary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
