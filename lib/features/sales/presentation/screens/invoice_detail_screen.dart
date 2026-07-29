import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive_center.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice_detail.dart';
import 'package:saudiaaaa/features/sales/presentation/controllers/sales_controller.dart';

/// Full invoice as a single Plans-branded document sheet.
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
        title: Text(AppStrings.invoiceDocument(isArabic)),
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
              child: _DocumentBody(
                detail: detail,
                isArabic: isArabic,
                locale: locale,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentBody extends StatelessWidget {
  const _DocumentBody({
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
    final statusColor = _statusColor(context, detail.status);
    final sheetRadius = BorderRadius.circular(22);

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: AppSpacing.screenPadding,
      children: [
        GlassSurface(
          padding: EdgeInsets.zero,
          borderRadius: sheetRadius,
          child: ClipRRect(
            borderRadius: sheetRadius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    boxShadow: AppEffects.glowShadow(
                      AppColors.brandPrimary,
                      blur: 24,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.28),
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
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.invoiceDocument(isArabic)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StatusBadge(
                              label: _statusLabel(detail.status, isArabic),
                              color: statusColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          detail.number,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Formatters.currency(detail.total, locale: locale),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.95),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _MetaGrid(
                        isArabic: isArabic,
                        locale: locale,
                        detail: detail,
                      ),
                      if (detail.lines.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.lg),
                        _SectionTitle(
                          title: AppStrings.invoiceItemsSection(isArabic),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _LinesTable(
                          lines: detail.lines,
                          locale: locale,
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      _TotalsBlock(
                        detail: detail,
                        isArabic: isArabic,
                        locale: locale,
                      ),
                      if (detail.notes != null &&
                          detail.notes!.trim().isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.lg),
                        _SectionTitle(title: AppStrings.notes(isArabic)),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          detail.notes!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colors.textSecondary,
                                    height: 1.45,
                                  ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
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
        InvoiceStatus.paid => AppStrings.paid(isArabic),
        InvoiceStatus.pending => AppStrings.pending(isArabic),
        InvoiceStatus.overdue => AppStrings.overdue(isArabic),
      };
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: context.appColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
    );
  }
}

class _MetaGrid extends StatelessWidget {
  const _MetaGrid({
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

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.inputFill.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.cardBorder.withValues(alpha: 0.7)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 420;
          final billTo = _MetaColumn(
            label: AppStrings.billTo(isArabic),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.customerName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                ),
                if (detail.customerEmail != null)
                  _MutedLine(detail.customerEmail!),
                if (detail.customerPhone != null)
                  _MutedLine(detail.customerPhone!),
              ],
            ),
          );
          final dates = _MetaColumn(
            label: AppStrings.issueDate(isArabic),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Formatters.date(detail.date, locale: locale),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                ),
                if (detail.dueDate != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    AppStrings.dueDate(isArabic),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Formatters.date(detail.dueDate!, locale: locale),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                  ),
                ],
              ],
            ),
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                billTo,
                const SizedBox(height: AppSpacing.md),
                dates,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: billTo),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: dates),
            ],
          );
        },
      ),
    );
  }
}

class _MetaColumn extends StatelessWidget {
  const _MetaColumn({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.appColors.textTertiary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        child,
      ],
    );
  }
}

class _MutedLine extends StatelessWidget {
  const _MutedLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.appColors.textSecondary,
            ),
      ),
    );
  }
}

class _LinesTable extends StatelessWidget {
  const _LinesTable({
    required this.lines,
    required this.locale,
  });

  final List<InvoiceLine> lines;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.cardBorder.withValues(alpha: 0.8)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < lines.length; i++) ...[
            if (i > 0)
              Divider(height: 1, color: colors.cardBorder.withValues(alpha: 0.7)),
            _LineRow(line: lines[i], locale: locale),
          ],
        ],
      ),
    );
  }
}

class _LineRow extends StatelessWidget {
  const _LineRow({
    required this.line,
    required this.locale,
  });

  final InvoiceLine line;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final qty = line.quantity == line.quantity.roundToDouble()
        ? line.quantity.toInt().toString()
        : line.quantity.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.description,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$qty × ${Formatters.currency(line.unitPrice, locale: locale)}'
                  '${line.vatAmount > 0 ? '  ·  VAT ${Formatters.currency(line.vatAmount, locale: locale)}' : ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            Formatters.currency(line.total, locale: locale),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

class _TotalsBlock extends StatelessWidget {
  const _TotalsBlock({
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

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandPrimary.withValues(alpha: 0.08),
            AppColors.brandAccent.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          _TotalRow(
            label: AppStrings.subtotal(isArabic),
            value: Formatters.currency(detail.subtotal, locale: locale),
          ),
          if (detail.discount > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _TotalRow(
              label: AppStrings.discount(isArabic),
              value:
                  '- ${Formatters.currency(detail.discount, locale: locale)}',
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          _TotalRow(
            label: AppStrings.vat(isArabic),
            value: Formatters.currency(detail.vatAmount, locale: locale),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(
              height: 1,
              color: colors.cardBorder.withValues(alpha: 0.8),
            ),
          ),
          _TotalRow(
            label: AppStrings.total(isArabic),
            value: Formatters.currency(detail.total, locale: locale),
            emphasize: true,
          ),
          if (detail.paidAmount > 0 || detail.balanceDue > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _TotalRow(
              label: AppStrings.amountPaid(isArabic),
              value: Formatters.currency(detail.paidAmount, locale: locale),
            ),
            const SizedBox(height: AppSpacing.sm),
            _TotalRow(
              label: AppStrings.balanceDue(isArabic),
              value: Formatters.currency(detail.balanceDue, locale: locale),
              color: detail.balanceDue > 0 ? colors.error : colors.success,
              emphasize: true,
            ),
          ],
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.color,
  });

  final String label;
  final String value;
  final bool emphasize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final valueStyle = emphasize
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: color ?? colors.textPrimary,
            )
        : Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color ?? colors.textPrimary,
            );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Text(value, style: valueStyle),
      ],
    );
  }
}
