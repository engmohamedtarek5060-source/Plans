import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';

/// Mini Plans “document” tile for the sales list.
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
        InvoiceStatus.paid => AppStrings.paid(isArabic),
        InvoiceStatus.pending => AppStrings.pending(isArabic),
        InvoiceStatus.overdue => AppStrings.overdue(isArabic),
      };

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final statusColor = _statusColor(context);
    final locale = isArabic ? 'ar' : 'en';
    final dateStr = Formatters.date(invoice.date, locale: locale);
    final itemsLabel = AppStrings.invoiceItems(isArabic).replaceAll(
      '{count}',
      '${invoice.itemCount}',
    );
    final radius = BorderRadius.circular(AppSpacing.cardRadius);

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: radius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: AppColors.brandGradient,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: const Icon(
                        Icons.insights_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        AppStrings.invoiceDocument(isArabic).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    StatusBadge(
                      label: _statusLabel(isArabic),
                      color: statusColor,
                      compact: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoice.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: colors.textPrimary,
                                    letterSpacing: -0.2,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isArabic ? invoice.customerAr : invoice.customer,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        Formatters.currency(invoice.amount, locale: locale),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: colors.cardBorder.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: colors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          dateStr,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.textTertiary,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 13,
                        color: colors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        itemsLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.textTertiary,
                            ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: statusColor.withValues(alpha: 0.85),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
