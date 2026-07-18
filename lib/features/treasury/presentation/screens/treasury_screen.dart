import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/kpi_card.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/core/widgets/section_header.dart';
import 'package:saudiaaaa/core/widgets/skeleton_loader.dart';
import 'package:saudiaaaa/features/treasury/domain/entities/bank_account.dart';
import 'package:saudiaaaa/features/treasury/presentation/controllers/treasury_controller.dart';

class TreasuryScreen extends ConsumerWidget {
  const TreasuryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final colors = context.appColors;
    final asyncState = ref.watch(treasuryControllerProvider);

    return RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: () => ref.read(treasuryControllerProvider.notifier).refresh(),
      child: asyncState.when(
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
                  ref.read(treasuryControllerProvider.notifier).refresh(),
            ),
          ],
        ),
        data: (state) {
          return ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: AppSpacing.screenPadding,
            children: [
              ScreenHeader(
                title: AppStrings.navTreasury(isArabic),
                subtitle:
                    isArabic ? 'إدارة النقد والبنوك' : 'Cash & bank management',
              ),
              const SizedBox(height: AppSpacing.lg),
              if (state.isEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                EmptyState(
                  title: AppStrings.emptyTitle(isArabic),
                  subtitle: isArabic
                      ? 'لم تتم إضافة حسابات بنكية بعد'
                      : 'No bank accounts have been added yet',
                ),
              ] else ...[
                HeroKpiCard(
                  title: isArabic ? 'الرصيد الإجمالي' : 'Total Balance',
                  value:
                      Formatters.currency(state.totalBalance, locale: locale),
                  icon: Icons.account_balance_wallet_outlined,
                  // No prior-period figure exists, so no trend is shown.
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        title: isArabic ? 'الحسابات' : 'Accounts',
                        value: '${state.accounts.length}',
                        icon: Icons.account_balance_outlined,
                        accentColor: AppColors.brandPrimary,
                        compact: true,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: KpiCard(
                        title: isArabic ? 'غير مطابقة' : 'Unreconciled',
                        value:
                            '${state.transactions.where((t) => !t.isReconciled).length}',
                        icon: Icons.rule_folder_outlined,
                        accentColor: colors.kpiExpense,
                        compact: true,
                      ),
                    ),
                  ],
                ),
                if (state.accounts.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  SectionHeader(
                    title: isArabic ? 'الحسابات البنكية' : 'Bank Accounts',
                  ),
                  ...state.accounts.map(
                    (account) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: _AccountTile(account: account, locale: locale),
                    ),
                  ),
                ],
                if (state.transactions.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  SectionHeader(
                    title: isArabic ? 'آخر المعاملات' : 'Recent Transactions',
                  ),
                  ...state.transactions.map(
                    (tx) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: _TransactionTile(
                        title: tx.description,
                        date: Formatters.date(tx.date, locale: locale),
                        amount: tx.amount,
                        isIncome: tx.isCredit,
                        locale: locale,
                      ),
                    ),
                  ),
                ],
              ],
              const SizedBox(height: AppSpacing.xxl),
            ],
          );
        },
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({required this.account, required this.locale});

  final BankAccount account;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AppCard(
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
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.accountName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${account.bankName} · ${account.maskedNumber}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: colors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            Formatters.currency(account.balance, locale: locale),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
    required this.locale,
  });

  final String title;
  final String date;
  final double amount;
  final bool isIncome;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = isIncome ? colors.success : colors.error;

    return AppCard(
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
                  accent.withValues(alpha: 0.2),
                  accent.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isIncome
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: accent,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            Formatters.signedCurrency(
              amount,
              locale: locale,
              positive: isIncome,
            ),
            // Keep the +/- sign attached before the number in RTL.
            textDirection: TextDirection.ltr,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: accent),
          ),
        ],
      ),
    );
  }
}
