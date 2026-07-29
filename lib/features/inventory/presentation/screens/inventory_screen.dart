import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/kpi_card.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/skeleton_loader.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';
import 'package:saudiaaaa/features/inventory/presentation/controllers/inventory_controller.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final colors = context.appColors;
    final asyncInventory = ref.watch(inventoryControllerProvider);

    return asyncInventory.when(
      loading: () => const Padding(
        padding: AppSpacing.screenPadding,
        child: KpiSkeletonGrid(),
      ),
      error: (error, stackTrace) => ErrorState(
        message: describeError(error, isArabic),
        retryLabel: AppStrings.retry(isArabic),
        onRetry: () =>
            ref.read(inventoryControllerProvider.notifier).refresh(),
      ),
      data: (state) => LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth;
          final columns = Responsive.gridColumns(contentWidth);
          // Inside the padded area the grid is a touch narrower than the
          // outer constraint; subtract horizontal screen padding so column
          // count matches what the user actually sees.
          final gridWidth =
              (contentWidth - AppSpacing.md * 2).clamp(0.0, contentWidth);
          final gridColumns = Responsive.gridColumns(gridWidth);

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(inventoryControllerProvider.notifier).refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverPadding(
                  padding: AppSpacing.screenPadding,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      ScreenHeader(
                        title: AppStrings.inventoryTitle(isArabic),
                        subtitle: AppStrings.totalProducts(isArabic),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _InventoryKpis(
                        isArabic: isArabic,
                        locale: locale,
                        totalProducts: state.summary.totalProducts,
                        lowStockCount: state.summary.lowStockCount,
                        totalValue: state.summary.totalValue,
                        wide: columns > 1,
                        colors: colors,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      CustomTextField(
                        controller: _searchController,
                        label: AppStrings.search(isArabic),
                        hint: AppStrings.search(isArabic),
                        prefixIcon: Icons.search_rounded,
                        onChanged: ref
                            .read(inventoryControllerProvider.notifier)
                            .setSearch,
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ]),
                  ),
                ),
                if (state.filteredProducts.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      title: AppStrings.emptyTitle(isArabic),
                      subtitle: AppStrings.emptySubtitle(isArabic),
                      icon: Icons.inventory_2_outlined,
                    ),
                  )
                else if (gridColumns <= 1)
                  SliverPadding(
                    padding: AppSpacing.screenPadding.copyWith(top: 0),
                    sliver: SliverList.separated(
                      itemCount: state.filteredProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.xs),
                      itemBuilder: (context, index) => _ProductCard(
                        product: state.filteredProducts[index],
                        isArabic: isArabic,
                        locale: locale,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: AppSpacing.screenPadding.copyWith(top: 0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridColumns,
                        mainAxisSpacing: AppSpacing.sm,
                        crossAxisSpacing: AppSpacing.sm,
                        // Tall enough for icon + name + sku + price + badge
                        // across text scales without clipping.
                        mainAxisExtent: context.responsive(
                          compact: 132,
                          medium: 140,
                          expanded: 148,
                        ),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ProductCard(
                          product: state.filteredProducts[index],
                          isArabic: isArabic,
                          locale: locale,
                          dense: true,
                        ),
                        childCount: state.filteredProducts.length,
                      ),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// KPI strip: three-up once there is room, otherwise two compact cards over a
/// full-width stock-value card so phones stay readable.
class _InventoryKpis extends StatelessWidget {
  const _InventoryKpis({
    required this.isArabic,
    required this.locale,
    required this.totalProducts,
    required this.lowStockCount,
    required this.totalValue,
    required this.wide,
    required this.colors,
  });

  final bool isArabic;
  final String locale;
  final int totalProducts;
  final int lowStockCount;
  final double totalValue;
  final bool wide;
  final AppColorExtension colors;

  @override
  Widget build(BuildContext context) {
    final total = KpiCard(
      title: AppStrings.totalProducts(isArabic),
      value: '$totalProducts',
      icon: Icons.inventory_2_outlined,
      accentColor: colors.kpiRevenue,
      compact: true,
    );
    final low = KpiCard(
      title: AppStrings.lowStock(isArabic),
      value: '$lowStockCount',
      icon: Icons.warning_amber_rounded,
      accentColor: colors.kpiExpense,
      compact: true,
    );
    final value = KpiCard(
      title: AppStrings.stockValue(isArabic),
      value: Formatters.currency(totalValue, locale: locale),
      icon: Icons.payments_outlined,
      accentColor: colors.kpiBalance,
      compact: wide,
    );

    if (wide) {
      return Row(
        children: [
          Expanded(child: total),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: low),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: value),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: total),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: low),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        value,
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.isArabic,
    required this.locale,
    this.dense = false,
  });

  final Product product;
  final bool isArabic;
  final String locale;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final statusColor = switch (product.status) {
      StockStatus.inStock => colors.success,
      StockStatus.lowStock => colors.warning,
      StockStatus.outOfStock => colors.error,
    };
    final statusLabel = switch (product.status) {
      StockStatus.inStock => isArabic ? 'متوفر' : 'In stock',
      StockStatus.lowStock => isArabic ? 'منخفض' : 'Low',
      StockStatus.outOfStock => isArabic ? 'نفد' : 'Out',
    };
    final iconSize = dense ? 40.0 : 44.0;

    return AppCard(
      padding: EdgeInsets.all(dense ? AppSpacing.sm : AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  statusColor.withValues(alpha: 0.2),
                  statusColor.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: statusColor,
              size: dense ? 20 : 22,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? product.nameAr : product.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: dense ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${product.sku} · ${isArabic ? product.categoryAr : product.category}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  Formatters.currency(product.unitPrice, locale: locale),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Cap the trailing metrics so long badges shrink instead of
          // overflowing, without stealing equal space from the product name.
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: dense ? 88 : 104,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    '${product.quantity}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                    maxLines: 1,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: StatusBadge(
                    label: statusLabel,
                    color: statusColor,
                    compact: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
