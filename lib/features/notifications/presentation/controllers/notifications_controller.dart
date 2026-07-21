import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/core/pagination/cursor_page.dart';
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

/// The paged notification list shown in the bell panel.
class NotificationsState {
  const NotificationsState({
    required this.page,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final CursorPage<AppNotification> page;

  /// True only while appending. Kept separate from the outer [AsyncValue] so
  /// fetching page 2 shows a footer spinner instead of collapsing the list
  /// already on screen back to a full-screen loader.
  final bool isLoadingMore;

  /// A failed *append*, which must not replace the pages already shown. The
  /// first page's failure goes through [AsyncValue.error] instead.
  final Object? loadMoreError;

  List<AppNotification> get items => page.items;
  bool get hasMore => page.hasMore;
  bool get isEmpty => page.items.isEmpty;

  NotificationsState copyWith({
    CursorPage<AppNotification>? page,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return NotificationsState(
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError:
          clearLoadMoreError ? null : (loadMoreError ?? this.loadMoreError),
    );
  }
}

final notificationsListProvider = AsyncNotifierProvider.autoDispose<
    NotificationsController, NotificationsState>(
  NotificationsController.new,
);

class NotificationsController
    extends AutoDisposeAsyncNotifier<NotificationsState> {
  @override
  Future<NotificationsState> build() async {
    final page = await ref.read(notificationsRepositoryProvider).list();
    return NotificationsState(page: page);
  }

  /// Fetches the next page and appends it.
  ///
  /// Guarded against re-entry: a fast scroll fires the trigger repeatedly, and
  /// without this each call would request the *same* cursor and append the same
  /// rows again.
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );

    try {
      final next = await ref
          .read(notificationsRepositoryProvider)
          .list(cursor: current.page.nextCursor);

      // The panel may have been closed, or refresh() may have reset the list,
      // while this was in flight — discard a result that no longer applies.
      final latest = state.valueOrNull;
      if (latest == null || !latest.isLoadingMore) return;

      state = AsyncData(
        latest.copyWith(page: latest.page.append(next), isLoadingMore: false),
      );
    } catch (e) {
      final latest = state.valueOrNull;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(isLoadingMore: false, loadMoreError: e),
      );
    }
  }

  /// Reloads from the first page, discarding any pages already appended.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final page = await ref.read(notificationsRepositoryProvider).list();
      return NotificationsState(page: page);
    });
  }

  Future<void> markAllRead() async {
    final repo = ref.read(notificationsRepositoryProvider);
    await repo.markAllRead();
    // Refresh both the list and the badge so the UI reflects the change.
    ref.invalidate(unreadNotificationsProvider);
    await refresh();
  }
}
