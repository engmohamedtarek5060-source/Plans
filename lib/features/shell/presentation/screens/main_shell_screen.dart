import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/animated_bottom_nav.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:saudiaaaa/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:saudiaaaa/features/more/presentation/screens/more_screen.dart';
import 'package:saudiaaaa/features/sales/presentation/screens/sales_screen.dart';
import 'package:saudiaaaa/features/shell/presentation/providers/shell_provider.dart';
import 'package:saudiaaaa/features/treasury/presentation/screens/treasury_screen.dart';

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static const _screens = [
    DashboardScreen(),
    SalesScreen(),
    InventoryScreen(),
    TreasuryScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(shellIndexProvider);
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;

    return Scaffold(
      extendBody: true,
      body: PremiumBackground(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
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
                          boxShadow: AppEffects.glowShadow(
                            AppColors.brandPrimary,
                            blur: 14,
                          ),
                        ),
                        child: const Icon(
                          Icons.insights_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.appName(isArabic),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.3,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              isArabic ? 'الفرع الرئيسي' : 'Main Branch',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: colors.textSecondary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      _NotificationButton(colors: colors),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 88),
                child: AnimatedSwitcher(
                  duration: AppEffects.normal,
                  switchInCurve: AppEffects.easeOut,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.02),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<int>(currentIndex),
                    child: _screens[currentIndex],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(shellIndexProvider.notifier).setIndex(index),
        items: [
          BottomNavItem(
            icon: Icons.grid_view_rounded,
            activeIcon: Icons.grid_view_rounded,
            label: AppStrings.navDashboard(isArabic),
          ),
          BottomNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long_rounded,
            label: AppStrings.navSales(isArabic),
          ),
          BottomNavItem(
            icon: Icons.inventory_2_outlined,
            activeIcon: Icons.inventory_2_rounded,
            label: AppStrings.navInventory(isArabic),
          ),
          BottomNavItem(
            icon: Icons.account_balance_wallet_outlined,
            activeIcon: Icons.account_balance_wallet_rounded,
            label: AppStrings.navTreasury(isArabic),
          ),
          BottomNavItem(
            icon: Icons.more_horiz_rounded,
            activeIcon: Icons.more_horiz_rounded,
            label: AppStrings.navMore(isArabic),
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.colors});

  final AppColorExtension colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.inputFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs + 2),
          child: Badge(
            label: const Text(
              '3',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
            backgroundColor: AppColors.brandPrimary,
            child: Icon(
              Icons.notifications_outlined,
              color: colors.textPrimary,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
