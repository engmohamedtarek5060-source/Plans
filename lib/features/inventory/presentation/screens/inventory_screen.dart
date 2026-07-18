import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
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
      data: (state) => RefreshIndicator(
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
                  Row(
                    children: [
                      Expanded(
                        child: KpiCard(
                          title: AppStrings.totalProducts(isArabic),
                          value: '${state.summary.totalProducts}',
                          icon: Icons.inventory_2_outlined,
                          accentColor: colors.kpiRevenue,
                          compact: true,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: KpiCard(
                          title: AppStrings.lowStock(isArabic),
                          value: '${state.summary.lowStockCount}',
                          icon: Icons.warning_amber_rounded,
                          accentColor: colors.kpiExpense,
                          compact: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  KpiCard(
                    title: AppStrings.stockValue(isArabic),
                    value: Formatters.currency(
                      state.summary.totalValue,
                      locale: locale,
                    ),
                    icon: Icons.payments_outlined,
                    accentColor: colors.kpiBalance,
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
                child: EmptyState(
                  title: AppStrings.emptyTitle(isArabic),
                  subtitle: AppStrings.emptySubtitle(isArabic),
                  icon: Icons.inventory_2_outlined,
                ),
              )
            else
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
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.isArabic,
    required this.locale,
  });

  final Product product;
  final bool isArabic;
  final String locale;

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

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
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
              size: 22,
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
                      ),
                  maxLines: 1,
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
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.quantity}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
              ),
              const SizedBox(height: 4),
              StatusBadge(
                label: statusLabel,
                color: statusColor,
                compact: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
