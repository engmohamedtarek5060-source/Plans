import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/widgets/app_chip.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/skeleton_loader.dart';
import 'package:saudiaaaa/features/sales/presentation/controllers/sales_controller.dart';
import 'package:saudiaaaa/features/sales/presentation/screens/invoice_detail_screen.dart';
import 'package:saudiaaaa/features/sales/presentation/widgets/invoice_card.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final asyncSales = ref.watch(salesControllerProvider);

    return asyncSales.when(
      loading: () => const Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(height: 32, width: 140, borderRadius: 8),
            SizedBox(height: AppSpacing.lg),
            SkeletonLoader(height: 52, borderRadius: 12),
            SizedBox(height: AppSpacing.md),
            SkeletonLoader(height: 36, borderRadius: 12),
            SizedBox(height: AppSpacing.lg),
            ListSkeleton(itemCount: 5),
          ],
        ),
      ),
      error: (error, stackTrace) => ErrorState(
        message: describeError(error, isArabic),
        retryLabel: AppStrings.retry(isArabic),
        onRetry: () => ref.read(salesControllerProvider.notifier).refresh(),
      ),
      data: (state) {
        return Column(
          children: [
            Padding(
              padding: AppSpacing.screenPadding.copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenHeader(
                    title: AppStrings.salesTitle(isArabic),
                    subtitle: AppStrings.invoices(isArabic),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CustomTextField(
                    controller: _searchController,
                    label: AppStrings.search(isArabic),
                    prefixIcon: Icons.search_rounded,
                    onChanged: ref
                        .read(salesControllerProvider.notifier)
                        .setSearch,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _FilterChips(
                    isArabic: isArabic,
                    stats: state.stats,
                    current: state.filter,
                    onSelected: ref
                        .read(salesControllerProvider.notifier)
                        .setFilter,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: state.filteredInvoices.isEmpty
                  ? EmptyState(
                      title: AppStrings.emptyTitle(isArabic),
                      subtitle: AppStrings.emptySubtitle(isArabic),
                      icon: Icons.receipt_long_outlined,
                    )
                  : RefreshIndicator(
                      onRefresh: () =>
                          ref.read(salesControllerProvider.notifier).refresh(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: AppSpacing.screenPadding,
                        itemCount: state.filteredInvoices.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (context, index) {
                          final invoice = state.filteredInvoices[index];
                          return InvoiceCard(
                            invoice: invoice,
                            isArabic: isArabic,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => InvoiceDetailScreen(
                                  invoiceId: invoice.rawId,
                                  invoiceNumber: invoice.id,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.isArabic,
    required this.stats,
    required this.current,
    required this.onSelected,
  });

  final bool isArabic;
  final Map<String, int> stats;
  final InvoiceFilter current;
  final ValueChanged<InvoiceFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final chips = [
      (InvoiceFilter.all, isArabic ? 'الكل' : 'All', null),
      (InvoiceFilter.paid, AppStrings.paid(isArabic), stats['paid']),
      (InvoiceFilter.pending, AppStrings.pending(isArabic), stats['pending']),
      (InvoiceFilter.overdue, AppStrings.overdue(isArabic), stats['overdue']),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) {
          final (filter, label, count) = chip;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
            child: AppChip(
              label: label,
              count: count,
              isSelected: current == filter,
              onTap: () => onSelected(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}
