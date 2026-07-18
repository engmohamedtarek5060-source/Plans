import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive_center.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice_detail.dart';
import 'package:saudiaaaa/features/sales/presentation/controllers/sales_controller.dart';

/// Full invoice view: header, customer, line items, and totals breakdown.
class InvoiceDetailScreen extends ConsumerWidget {
  const InvoiceDetailScreen({
    super.key,
    required this.invoiceId,
    required this.invoiceNumber,
  });

  final int invoiceId;
  final String invoiceNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final asyncDetail = ref.watch(invoiceDetailProvider(invoiceId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(invoiceNumber),
      ),
      body: PremiumBackground(
        child: SafeArea(
          child: asyncDetail.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.brandPrimary),
            ),
            error: (error, _) => ErrorState(
              message: describeError(error, isArabic),
              retryLabel: AppStrings.retry(isArabic),
              onRetry: () => ref.invalidate(invoiceDetailProvider(invoiceId)),
            ),
            data: (detail) => ResponsiveCenter(
              child: _Body(detail: detail, isArabic: isArabic, locale: locale),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.detail,
    required this.isArabic,
    required this.locale,
  });

  final InvoiceDetail detail;
  final bool isArabic;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: AppSpacing.screenPadding,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                detail.number,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            StatusBadge(
              label: _statusLabel(detail.status, isArabic),
              color: _statusColor(context, detail.status),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Customer
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(context, isArabic ? 'العميل' : 'Customer'),
              const SizedBox(height: AppSpacing.xs),
              Text(
                detail.customerName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (detail.customerEmail != null)
                _muted(context, detail.customerEmail!),
              if (detail.customerPhone != null)
                _muted(context, detail.customerPhone!),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Dates
        AppCard(
          child: Column(
            children: [
              _row(
                context,
                isArabic ? 'تاريخ الإصدار' : 'Issue date',
                Formatters.date(detail.date, locale: locale),
              ),
              if (detail.dueDate != null) ...[
                const Divider(height: AppSpacing.lg),
                _row(
                  context,
                  isArabic ? 'تاريخ الاستحقاق' : 'Due date',
                  Formatters.date(detail.dueDate!, locale: locale),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Line items
        if (detail.lines.isNotEmpty) ...[
          _label(context, isArabic ? 'البنود' : 'Items'),
          const SizedBox(height: AppSpacing.xs),
          AppCard(
            child: Column(
              children: [
                for (var i = 0; i < detail.lines.length; i++) ...[
                  if (i > 0) const Divider(height: AppSpacing.lg),
                  _LineRow(line: detail.lines[i], locale: locale, isArabic: isArabic),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Totals
        AppCard(
          child: Column(
            children: [
              _row(
                context,
                isArabic ? 'المجموع الفرعي' : 'Subtotal',
                Formatters.currency(detail.subtotal, locale: locale),
              ),
              if (detail.discount > 0) ...[
                const SizedBox(height: AppSpacing.sm),
                _row(
                  context,
                  isArabic ? 'الخصم' : 'Discount',
                  '- ${Formatters.currency(detail.discount, locale: locale)}',
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              _row(
                context,
                isArabic ? 'الضريبة' : 'VAT',
                Formatters.currency(detail.vatAmount, locale: locale),
              ),
              const Divider(height: AppSpacing.xl),
              _row(
                context,
                isArabic ? 'الإجمالي' : 'Total',
                Formatters.currency(detail.total, locale: locale),
                emphasize: true,
              ),
              if (detail.paidAmount > 0) ...[
                const SizedBox(height: AppSpacing.sm),
                _row(
                  context,
                  isArabic ? 'المدفوع' : 'Paid',
                  Formatters.currency(detail.paidAmount, locale: locale),
                ),
                const SizedBox(height: AppSpacing.sm),
                _row(
                  context,
                  isArabic ? 'المتبقي' : 'Balance due',
                  Formatters.currency(detail.balanceDue, locale: locale),
                  color: detail.balanceDue > 0 ? colors.error : colors.success,
                ),
              ],
            ],
          ),
        ),

        if (detail.notes != null && detail.notes!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(context, isArabic ? 'ملاحظات' : 'Notes'),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  detail.notes!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  Widget _label(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: context.appColors.textSecondary,
              letterSpacing: 0.3,
            ),
      );

  Widget _muted(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: context.appColors.textSecondary),
        ),
      );

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    bool emphasize = false,
    Color? color,
  }) {
    final style = emphasize
        ? Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w800)
        : Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.appColors.textSecondary,
              ),
        ),
        Text(value, style: style?.copyWith(color: color)),
      ],
    );
  }

  static Color _statusColor(BuildContext context, InvoiceStatus status) {
    final colors = context.appColors;
    return switch (status) {
      InvoiceStatus.paid => colors.success,
      InvoiceStatus.pending => colors.warning,
      InvoiceStatus.overdue => colors.error,
    };
  }

  static String _statusLabel(InvoiceStatus status, bool isArabic) =>
      switch (status) {
        InvoiceStatus.paid => isArabic ? 'مدفوعة' : 'Paid',
        InvoiceStatus.pending => isArabic ? 'معلقة' : 'Pending',
        InvoiceStatus.overdue => isArabic ? 'متأخرة' : 'Overdue',
      };
}

class _LineRow extends StatelessWidget {
  const _LineRow({
    required this.line,
    required this.locale,
    required this.isArabic,
  });

  final InvoiceLine line;
  final String locale;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    // Trim a trailing .0 so "10 × ..." doesn't read "10.0 × ...".
    final qty = line.quantity == line.quantity.roundToDouble()
        ? line.quantity.toInt().toString()
        : line.quantity.toString();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                line.description,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                '$qty × ${Formatters.currency(line.unitPrice, locale: locale)}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          Formatters.currency(line.total, locale: locale),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
