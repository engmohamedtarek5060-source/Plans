import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/kpi_card.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/section_header.dart';
import 'package:saudiaaaa/core/widgets/skeleton_loader.dart';
import 'package:saudiaaaa/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:saudiaaaa/features/dashboard/presentation/widgets/activity_list_tile.dart';
import 'package:saudiaaaa/features/dashboard/presentation/widgets/chart_placeholder.dart';
import 'package:saudiaaaa/features/dashboard/presentation/widgets/quick_action_chip.dart';
import 'package:saudiaaaa/features/shell/presentation/providers/shell_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  /// Null trend -> null label, which makes [KpiCard] hide the trend chip.
  static String? _trendLabel(double? trend, String locale) =>
      trend == null ? null : Formatters.percent(trend, locale: locale);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final colors = context.appColors;
    final asyncStats = ref.watch(dashboardControllerProvider);

    return RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
      child: asyncStats.when(
        loading: () => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSpacing.screenPadding,
          children: const [KpiSkeletonGrid()],
        ),
        error: (error, _) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ErrorState(
              message: describeError(error, isArabic),
              retryLabel: AppStrings.retry(isArabic),
              onRetry: () =>
                  ref.read(dashboardControllerProvider.notifier).refresh(),
            ),
          ],
        ),
        data: (stats) {
          // Only a tenant with no data at all gets the empty state. A real
          // company with revenue but no invoices this week still sees its KPIs.
          if (stats.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.screenPadding,
              children: [
                ScreenHeader(
                  title: AppStrings.greeting(isArabic),
                  subtitle: AppStrings.dashboardTitle(isArabic),
                ),
                const SizedBox(height: AppSpacing.xxl),
                EmptyState(
                  title: AppStrings.emptyTitle(isArabic),
                  subtitle: AppStrings.emptySubtitle(isArabic),
                ),
              ],
            );
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: AppSpacing.screenPadding,
            children: [
              ScreenHeader(
                title: AppStrings.greeting(isArabic),
                subtitle: AppStrings.dashboardTitle(isArabic),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: KpiCard(
                      title: AppStrings.revenue(isArabic),
                      value: Formatters.currency(stats.revenue, locale: locale),
                      icon: Icons.trending_up_rounded,
                      accentColor: colors.kpiRevenue,
                      // The backend exposes no prior-period baseline, so there
                      // is no trend to show rather than a made-up one.
                      trend: _trendLabel(stats.revenueTrend, locale),
                      trendUp: (stats.revenueTrend ?? 0) > 0,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: KpiCard(
                      title: AppStrings.expenses(isArabic),
                      value:
                          Formatters.currency(stats.expenses, locale: locale),
                      icon: Icons.trending_down_rounded,
                      accentColor: colors.kpiExpense,
                      trend: _trendLabel(stats.expensesTrend?.abs(), locale),
                      trendUp: (stats.expensesTrend ?? 0) < 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              HeroKpiCard(
                title: AppStrings.balance(isArabic),
                value: Formatters.currency(stats.balance, locale: locale),
                icon: Icons.account_balance_wallet_outlined,
                trend: _trendLabel(stats.balanceTrend, locale),
                trendUp: (stats.balanceTrend ?? 0) > 0,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Nothing to plot for a tenant with no sales history.
              if (stats.chartData.isNotEmpty) ...[
                ChartPlaceholder(
                  data: stats.chartData,
                  label: AppStrings.overview(isArabic),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
              SectionHeader(title: AppStrings.quickActions(isArabic)),
              SizedBox(
                height: 116,
                child: Row(
                  children: [
                    Expanded(
                      child: QuickActionChip(
                        icon: Icons.receipt_long_rounded,
                        label: AppStrings.newInvoice(isArabic),
                        color: colors.kpiRevenue,
                        onTap: () =>
                            ref.read(shellIndexProvider.notifier).setIndex(1),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: QuickActionChip(
                        icon: Icons.add_card_outlined,
                        label: AppStrings.addExpense(isArabic),
                        color: colors.kpiExpense,
                        onTap: () =>
                            ref.read(shellIndexProvider.notifier).setIndex(4),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: QuickActionChip(
                        icon: Icons.inventory_2_outlined,
                        label: AppStrings.inventoryTitle(isArabic),
                        color: colors.kpiBalance,
                        onTap: () =>
                            ref.read(shellIndexProvider.notifier).setIndex(2),
                      ),
                    ),
                  ],
                ),
              ),
              // Skip the whole section rather than show a header over nothing.
              if (stats.recentActivities.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                SectionHeader(
                  title: AppStrings.recentActivity(isArabic),
                  actionLabel: AppStrings.viewAll(isArabic),
                  onAction: () =>
                      ref.read(shellIndexProvider.notifier).setIndex(1),
                ),
                ...stats.recentActivities.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: ActivityListTile(item: item, isArabic: isArabic),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
            ],
          );
        },
      ),
    );
  }
}
