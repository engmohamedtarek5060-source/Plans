import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({
    super.key,
    required this.isArabic,
    required this.onNewInvoice,
    required this.onAddExpense,
    required this.onViewInventory,
    required this.onViewReports,
  });

  final bool isArabic;
  final VoidCallback onNewInvoice;
  final VoidCallback onAddExpense;
  final VoidCallback onViewInventory;
  final VoidCallback onViewReports;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        icon: Icons.receipt_long_rounded,
        label: AppStrings.newInvoice(isArabic),
        color: AppColors.brandPrimary,
        onTap: onNewInvoice,
      ),
      _QuickAction(
        icon: Icons.payments_outlined,
        label: AppStrings.addExpense(isArabic),
        color: AppColors.brandWarning,
        onTap: onAddExpense,
      ),
      _QuickAction(
        icon: Icons.inventory_2_outlined,
        label: AppStrings.inventoryTitle(isArabic),
        color: AppColors.brandAccent,
        onTap: onViewInventory,
      ),
      _QuickAction(
        icon: Icons.bar_chart_rounded,
        label: AppStrings.overview(isArabic),
        color: const Color(0xFF8B5CF6),
        onTap: onViewReports,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.6,
      children: actions.map((action) {
        return AppCard(
          onTap: action.onTap,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                ),
                child: Icon(action.icon, color: action.color, size: 22),
              ),
              const Spacer(),
              Text(
                action.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: context.appColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
}
