import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.isArabic,
    this.onTap,
  });

  final Invoice invoice;
  final bool isArabic;
  final VoidCallback? onTap;

  Color _statusColor(BuildContext context) {
    final colors = context.appColors;
    return switch (invoice.status) {
      InvoiceStatus.paid => colors.success,
      InvoiceStatus.pending => colors.warning,
      InvoiceStatus.overdue => colors.error,
    };
  }

  String _statusLabel(bool isArabic) => switch (invoice.status) {
        InvoiceStatus.paid => isArabic ? 'مدفوعة' : 'Paid',
        InvoiceStatus.pending => isArabic ? 'معلقة' : 'Pending',
        InvoiceStatus.overdue => isArabic ? 'متأخرة' : 'Overdue',
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final statusColor = _statusColor(context);
    final dateStr =
        DateFormat.yMMMd(isArabic ? 'ar' : 'en').format(invoice.date);

    return AppCard(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    statusColor,
                    statusColor.withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        invoice.id,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                      ),
                      const Spacer(),
                      StatusBadge(
                        label: _statusLabel(isArabic),
                        color: statusColor,
                        compact: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    isArabic ? invoice.customerAr : invoice.customer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    dateStr,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textTertiary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Formatters.currency(
                    invoice.amount,
                    locale: isArabic ? 'ar' : 'en',
                  ),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: colors.textTertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
