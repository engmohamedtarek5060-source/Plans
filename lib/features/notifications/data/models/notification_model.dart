import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/notifications/domain/entities/app_notification.dart';

/// Maps a notification row onto [AppNotification].
///
/// The backend ships no schema for this payload and the endpoint returned an
/// empty list on every tenant reachable during development, so the exact field
/// names are unverified. Parsing is therefore deliberately defensive: it tries
/// the field names NestJS notification modules conventionally use and falls
/// back rather than throwing, so an unexpected shape degrades to a readable row
/// instead of crashing the panel.
class NotificationModel {
  const NotificationModel._();

  static AppNotification fromJson(Map<String, dynamic> json) {
    final title = asStringOrNull(json['title']) ??
        asStringOrNull(json['subject']) ??
        asStringOrNull(json['type']) ??
        'Notification';

    final body = asStringOrNull(json['body']) ??
        asStringOrNull(json['message']) ??
        asStringOrNull(json['content']) ??
        asStringOrNull(json['description']) ??
        '';

    final createdAt = asDateOrNull(json['createdAt']) ??
        asDateOrNull(json['created_at']) ??
        asDateOrNull(json['timestamp']);

    // Prefer an explicit read flag; fall back to the presence of a readAt time.
    final isRead = json.containsKey('isRead') || json.containsKey('read')
        ? (asBool(json['isRead']) || asBool(json['read']))
        : asDateOrNull(json['readAt']) != null;

    return AppNotification(
      id: asString(json['id']),
      title: title,
      body: body,
      createdAt: createdAt,
      isRead: isRead,
    );
  }
}
