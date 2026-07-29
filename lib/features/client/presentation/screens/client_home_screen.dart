import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive_center.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';

/// Landing screen for client (USER) accounts.
///
/// A scaffold for now: client-facing endpoints aren't wired yet. Logout returns
/// to the shared login screen; post-auth routing decides this vs the company
/// shell from the server role.
class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: GlassSurface(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.brandGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            AppStrings.clientHomeTitle(isArabic),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<AuthCubit>().logout(),
                          icon: Icon(
                            Icons.logout_rounded,
                            color: colors.textPrimary,
                          ),
                          tooltip: AppStrings.logout(isArabic),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: AppStrings.clientHomeEmptyTitle(isArabic),
                    subtitle: AppStrings.clientHomeEmptySubtitle(isArabic),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
