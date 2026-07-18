import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
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

  /// Recent notifications. The endpoint is cursor-paginated and wraps its rows
  /// as `{data: [...], nextCursor}`; [asListResponse] unwraps the `data` key.
  Future<List<AppNotification>> list() async {
    final json = await _api.getObject(ApiEndpoints.notifications);
    return asListResponse(json['data'] ?? json)
        .map(NotificationModel.fromJson)
        .toList();
  }

  Future<void> markAllRead() =>
      _api.post(ApiEndpoints.notificationsReadAll);
}
