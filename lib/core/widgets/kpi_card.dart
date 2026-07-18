import 'package:flutter/material.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/app_card.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
    this.trend,
    this.trendUp,
    this.onTap,
    this.compact = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;
  final String? trend;
  final bool? trendUp;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(compact ? AppSpacing.sm + 2 : AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accentColor.withValues(alpha: 0.2),
                      accentColor.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.chipRadius + 2,
                  ),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Icon(
                  icon,
                  size: compact ? 18 : 20,
                  color: accentColor,
                  textDirection: TextDirection.ltr,
                ),
              ),
              const Spacer(),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: (trendUp == true ? colors.success : colors.error)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                  ),
                  // Trend arrows and signed numbers must not be mirrored by
                  // RTL, otherwise an upward trend reads as a decline.
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(
                        trendUp == true
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 14,
                        color: trendUp == true ? colors.success : colors.error,
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend!,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: trendUp == true
                              ? colors.success
                              : colors.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
          // Scale long amounts down instead of truncating them.
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class HeroKpiCard extends StatelessWidget {
  const HeroKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.trend,
    this.trendUp,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? trend;
  final bool? trendUp;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      gradient: AppColors.brandGradient,
      borderColor: AppColors.brandPrimary.withValues(alpha: 0.3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.75,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (trend != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  // LTR so the arrow and the +/- sign are not mirrored in RTL.
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(
                        trendUp == true
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trend!,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}
