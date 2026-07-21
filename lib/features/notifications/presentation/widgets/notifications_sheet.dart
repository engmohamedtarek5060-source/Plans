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
                    if (asyncList.valueOrNull?.items.any((n) => !n.isRead) ??
                        false)
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
                  data: (data) {
                    if (data.isEmpty) {
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

                    final items = data.items;
                    // One trailing slot for the load-more footer, so the
                    // spinner scrolls with the list instead of pinning to the
                    // sheet and covering the last row.
                    final itemCount = items.length + (data.hasMore ? 1 : 0);

                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        // Prefetch a screen early so the next page is usually
                        // there by the time the user reaches the end.
                        final metrics = notification.metrics;
                        if (metrics.axis == Axis.vertical &&
                            metrics.extentAfter < 300) {
                          ref
                              .read(notificationsListProvider.notifier)
                              .loadMore();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          AppSpacing.xl,
                        ),
                        itemCount: itemCount,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (context, i) {
                          if (i >= items.length) {
                            return _LoadMoreFooter(
                              error: data.loadMoreError,
                              isArabic: isArabic,
                              onRetry: () => ref
                                  .read(notificationsListProvider.notifier)
                                  .loadMore(),
                            );
                          }
                          return _NotificationTile(
                            notification: items[i],
                            locale: locale,
                          );
                        },
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

/// Trailing row while more pages exist: a spinner normally, or an inline retry
/// if the append failed.
///
/// The failure is shown here rather than replacing the sheet with a full error
/// state — the pages already loaded are still valid and still useful.
class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter({
    required this.error,
    required this.isArabic,
    required this.onRetry,
  });

  final Object? error;
  final bool isArabic;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          children: [
            Text(
              describeError(error!, isArabic),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: context.appColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextButton(
              onPressed: onRetry,
              child: Text(AppStrings.retry(isArabic)),
            ),
          ],
        ),
      );
    }

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
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
