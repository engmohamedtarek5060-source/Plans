import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';
import 'package:saudiaaaa/core/widgets/status_badge.dart';
import 'package:saudiaaaa/features/dashboard/domain/entities/activity_item.dart';

class ActivityListTile extends StatelessWidget {
  const ActivityListTile({
    super.key,
    required this.item,
    required this.isArabic,
  });

  final ActivityItem item;
  final bool isArabic;

  IconData _iconFor(String name) => switch (name) {
    'receipt' => Icons.receipt_long_rounded,
    'home' => Icons.home_work_outlined,
    'inventory' => Icons.inventory_2_outlined,
    _ => Icons.swap_horiz_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = item.isIncome ? colors.success : colors.error;

    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs + 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.2),
                  accent.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.chipRadius + 2),
            ),
            child: Icon(_iconFor(item.iconName), size: 20, color: accent),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? item.titleAr : item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  isArabic ? item.subtitleAr : item.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
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
                Formatters.signedCurrency(
                  item.amount,
                  locale: isArabic ? 'ar' : 'en',
                  positive: item.isIncome,
                ),
                // Keep the +/- sign attached before the number in RTL.
                textDirection: TextDirection.ltr,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: accent),
              ),
              const SizedBox(height: 4),
              StatusBadge(
                label: item.isIncome
                    ? (isArabic ? 'دخل' : 'Income')
                    : (isArabic ? 'مصروف' : 'Expense'),
                color: accent,
                compact: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
