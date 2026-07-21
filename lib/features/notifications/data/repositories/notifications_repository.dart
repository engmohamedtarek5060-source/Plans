import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/core/pagination/cursor_page.dart';
import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/notifications/data/models/notification_model.dart';
import 'package:saudiaaaa/features/notifications/domain/entities/app_notification.dart';

class NotificationsRepository {
  const NotificationsRepository(this._api);

  final ApiService _api;

  /// Unread count for the bell badge. `GET /notifications/unread-count`
  /// returns `{count: int}` (verified).
  Future<int> unreadCount() async {
    final json = await _api.getObject(ApiEndpoints.notificationsUnreadCount);
    return asInt(json['count']);
  }

  /// The backend rejects `limit` outside 1..200 with a 400, so this is a hard
  /// ceiling rather than a preference.
  static const int maxPageSize = 200;
  static const int defaultPageSize = 20;

  /// One page of notifications, newest first.
  ///
  /// `GET /notifications` answers `{data: [...], nextCursor}` (verified live).
  /// Pass [cursor] from the previous page's [CursorPage.nextCursor] to continue;
  /// omit it for the first page.
  Future<CursorPage<AppNotification>> list({
    String? cursor,
    int limit = defaultPageSize,
    bool unreadOnly = false,
  }) async {
    final json = await _api.getObject(
      ApiEndpoints.notifications,
      query: {
        'limit': limit.clamp(1, maxPageSize),
        'cursor': ?cursor,
        if (unreadOnly) 'unreadOnly': true,
      },
    );

    return CursorPage<AppNotification>(
      // Tolerate a bare array too: the envelope is what ships today, but
      // asListResponse already handles both and costs nothing here.
      items: asListResponse(json['data'] ?? json)
          .map(NotificationModel.fromJson)
          .toList(),
      nextCursor: asStringOrNull(json['nextCursor']),
    );
  }

  Future<void> markAllRead() =>
      _api.post(ApiEndpoints.notificationsReadAll);
}
