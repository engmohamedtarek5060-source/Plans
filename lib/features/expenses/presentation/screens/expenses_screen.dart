import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/skeleton_loader.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/presentation/controllers/expenses_controller.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
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
    final asyncExpenses = ref.watch(expensesControllerProvider);

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: asyncExpenses.when(
            loading: () => const Padding(
              padding: AppSpacing.screenPadding,
              child: KpiSkeletonGrid(),
            ),
            error: (error, stackTrace) => ErrorState(
              message: describeError(error, isArabic),
              retryLabel: AppStrings.retry(isArabic),
              onRetry: () =>
                  ref.read(expensesControllerProvider.notifier).refresh(),
            ),
            data: (state) => RefreshIndicator(
              onRefresh: () =>
                  ref.read(expensesControllerProvider.notifier).refresh(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: AppSpacing.screenPadding,
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            onPressed: () => Navigator.of(context).pop(),
                            style: IconButton.styleFrom(
                              backgroundColor: colors.inputFill,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ScreenHeader(
                          title: AppStrings.expensesTitle(isArabic),
                          subtitle: AppStrings.totalExpenses(isArabic),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        KpiCard(
                          title: AppStrings.totalExpenses(isArabic),
                          value: Formatters.currency(
                            state.total,
                            locale: locale,
                          ),
                          icon: Icons.account_balance_wallet_outlined,
                          accentColor: colors.kpiExpense,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        CustomTextField(
                          controller: _searchController,
                          label: AppStrings.search(isArabic),
                          prefixIcon: Icons.search_rounded,
                          onChanged: ref
                              .read(expensesControllerProvider.notifier)
                              .setSearch,
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ]),
                    ),
                  ),
                  if (state.filteredExpenses.isEmpty)
                    SliverFillRemaining(
                      child: EmptyState(
                        title: AppStrings.emptyTitle(isArabic),
                        subtitle: AppStrings.emptySubtitle(isArabic),
                        icon: Icons.receipt_outlined,
                      ),
                    )
                  else
                    SliverPadding(
                      padding: AppSpacing.screenPadding.copyWith(top: 0),
                      sliver: SliverList.separated(
                        itemCount: state.filteredExpenses.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (context, index) => _ExpenseCard(
                          expense: state.filteredExpenses[index],
                          isArabic: isArabic,
                          locale: locale,
                        ),
                      ),
                    ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  const _ExpenseCard({
    required this.expense,
    required this.isArabic,
    required this.locale,
  });

  final Expense expense;
  final bool isArabic;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dateStr = DateFormat.yMMMd(
      isArabic ? 'ar' : 'en',
    ).format(expense.date);

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.kpiExpense.withValues(alpha: 0.2),
                  colors.kpiExpense.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              color: colors.kpiExpense,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? expense.titleAr : expense.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${isArabic ? expense.categoryAr : expense.category} · $dateStr',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            Formatters.currency(expense.amount, locale: locale),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: colors.error,
            ),
          ),
        ],
      ),
    );
  }
}
