import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive.dart';
import 'package:saudiaaaa/core/responsive/responsive_center.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/presentation/controllers/role_selection_controller.dart';
import 'package:saudiaaaa/features/role/presentation/widgets/role_option_card.dart';

/// First-launch entry screen: pick the flow the app opens into.
///
/// Shown by the root gate whenever no role is persisted. Committing the choice
/// updates the gate, which swaps the tree — this screen never navigates.
class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final state = ref.watch(roleSelectionControllerProvider);
    final controller = ref.read(roleSelectionControllerProvider.notifier);
    final colors = context.appColors;

    final options = [
      RoleOptionCard(
        icon: Icons.person_outline_rounded,
        title: AppStrings.roleClient(isArabic),
        description: AppStrings.roleClientDescription(isArabic),
        isSelected: state.isSelected(UserRole.client),
        selectedLabel: AppStrings.selected(isArabic),
        onTap: state.isSaving ? null : () => controller.select(UserRole.client),
      ),
      RoleOptionCard(
        icon: Icons.storefront_outlined,
        title: AppStrings.roleCompany(isArabic),
        description: AppStrings.roleCompanyDescription(isArabic),
        isSelected: state.isSelected(UserRole.company),
        selectedLabel: AppStrings.selected(isArabic),
        onTap: state.isSaving ? null : () => controller.select(UserRole.company),
      ),
    ];

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  Expanded(
                    // Scrollable so a small phone in landscape, or a large font
                    // scale, degrades to scrolling instead of overflowing.
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: AppSpacing.xl),
                          const _BrandMark(),
                          const SizedBox(height: AppSpacing.xl),
                          Text(
                            AppStrings.chooseRoleTitle(isArabic),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            AppStrings.chooseRoleSubtitle(isArabic),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: colors.textSecondary,
                                    ),
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          _OptionsLayout(options: options),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                      ),
                    ),
                  ),
                  _ErrorBanner(
                    // Persisting swallows storage failures, so this only shows
                    // on an unexpected throw — but the user still gets a way
                    // forward rather than a Continue button that does nothing.
                    message: state.hasError
                        ? AppStrings.roleSaveFailed(isArabic)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  CustomPrimaryButton(
                    label: AppStrings.continueLabel(isArabic),
                    size: ButtonSize.lg,
                    useGradient: true,
                    isLoading: state.isSaving,
                    // Null until a role is picked: the button renders itself
                    // dimmed and ignores taps.
                    onPressed: state.canContinue ? controller.confirm : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Side-by-side on wide screens, stacked on phones.
class _OptionsLayout extends StatelessWidget {
  const _OptionsLayout({required this.options});

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    if (!context.isWide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, option) in options.indexed) ...[
            if (index > 0) const SizedBox(height: AppSpacing.md),
            option,
          ],
        ],
      );
    }

    // IntrinsicHeight so both tiles match the taller one; without it, stretch
    // inside a scroll view has no bounded height to resolve against.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, option) in options.indexed) ...[
            if (index > 0) const SizedBox(width: AppSpacing.md),
            Expanded(child: option),
          ],
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppEffects.glowShadow(AppColors.brandPrimary, blur: 20),
        ),
        child: const Icon(
          Icons.insights_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

/// Collapses to nothing when there is no error, and animates its own height so
/// the Continue button doesn't jump.
class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedSize(
      duration: AppEffects.fast,
      curve: AppEffects.easeOut,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 18,
                    color: colors.error,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      message!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.error,
                          ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
