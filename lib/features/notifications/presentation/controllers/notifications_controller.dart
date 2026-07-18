import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/notifications/data/repositories/notifications_repository.dart';
import 'package:saudiaaaa/features/notifications/domain/entities/app_notification.dart';

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.watch(apiServiceProvider)),
);

/// Unread count for the bell badge.
///
/// A failure resolves to 0 rather than an error: the badge is ambient chrome,
/// so a network blip must never surface an error box on the shell.
final unreadNotificationsProvider = FutureProvider.autoDispose<int>((ref) async {
  try {
    return await ref.watch(notificationsRepositoryProvider).unreadCount();
  } catch (_) {
    return 0;
  }
});

/// The notification list shown in the bell panel.
final notificationsListProvider =
    AsyncNotifierProvider.autoDispose<NotificationsController, List<AppNotification>>(
  NotificationsController.new,
);

class NotificationsController
    extends AutoDisposeAsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() {
    return ref.read(notificationsRepositoryProvider).list();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(notificationsRepositoryProvider).list(),
    );
  }

  Future<void> markAllRead() async {
    final repo = ref.read(notificationsRepositoryProvider);
    await repo.markAllRead();
    // Refresh both the list and the badge so the UI reflects the change.
    ref.invalidate(unreadNotificationsProvider);
    await refresh();
  }
}
