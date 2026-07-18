import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/features/notifications/domain/entities/app_notification.dart';
import 'package:saudiaaaa/features/notifications/presentation/controllers/notifications_controller.dart';

/// Bottom sheet listing recent notifications, opened from the bell.
class NotificationsSheet extends ConsumerWidget {
  const NotificationsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NotificationsSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final colors = context.appColors;
    final asyncList = ref.watch(notificationsListProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.textTertiary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isArabic ? 'الإشعارات' : 'Notifications',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    // Only offer "mark all read" when there is something to read.
                    if (asyncList.valueOrNull?.any((n) => !n.isRead) ?? false)
                      TextButton(
                        onPressed: () => ref
                            .read(notificationsListProvider.notifier)
                            .markAllRead(),
                        child: Text(
                          isArabic ? 'تعليم الكل كمقروء' : 'Mark all read',
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: asyncList.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  error: (error, _) => ListView(
                    controller: scrollController,
                    children: [
                      const SizedBox(height: AppSpacing.xxl),
                      ErrorState(
                        message: describeError(error, isArabic),
                        retryLabel: AppStrings.retry(isArabic),
                        onRetry: () => ref
                            .read(notificationsListProvider.notifier)
                            .refresh(),
                      ),
                    ],
                  ),
                  data: (items) {
                    if (items.isEmpty) {
                      return ListView(
                        controller: scrollController,
                        children: [
                          const SizedBox(height: AppSpacing.xxl),
                          EmptyState(
                            title: isArabic ? 'لا إشعارات' : 'No notifications',
                            subtitle: isArabic
                                ? 'ستظهر الإشعارات الجديدة هنا'
                                : 'New notifications will appear here',
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.xl,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.xs),
                      itemBuilder: (context, i) => _NotificationTile(
                        notification: items[i],
                        locale: locale,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.locale});

  final AppNotification notification;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final unread = !notification.isRead;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: unread
            ? AppColors.brandPrimary.withValues(alpha: 0.06)
            : colors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: unread ? AppColors.brandPrimary : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight:
                            unread ? FontWeight.w700 : FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                ),
                if (notification.body.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    notification.body,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: colors.textSecondary),
                  ),
                ],
                if (notification.createdAt != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    Formatters.date(notification.createdAt!, locale: locale),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: colors.textTertiary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
