import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final IconData icon;
  final Color iconColor;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.icon,
    required this.iconColor,
  });
}

enum NotificationType { success, reminder, warning, help }

class NotificationData {
  static List<NotificationModel> getNotifications({required bool isEnglish}) {
    return [
      NotificationModel(
        id: '1',
        title: isEnglish
            ? 'Leave Request Approved'
            : 'تمت الموافقة على طلب الإجازة',
        description: isEnglish
            ? 'Your leave request from Feb 1-3 has been approved'
            : 'تمت الموافقة على طلب إجازتك من 1-3 فبراير',
        time: isEnglish ? '2 hours ago' : 'منذ ساعتين',
        type: NotificationType.success,
        icon: Icons.check,
        iconColor: Colors.green,
      ),
      NotificationModel(
        id: '2',
        title: isEnglish ? 'Salary Payment Date' : 'موعد صرف الراتب',
        description: isEnglish
            ? 'January salary will be paid next Thursday'
            : 'سيتم صرف راتب شهر يناير يوم الخميس القادم',
        time: isEnglish ? '5 hours ago' : 'منذ 5 ساعات',
        type: NotificationType.reminder,
        icon: Icons.notifications,
        iconColor: Colors.blue,
      ),
      NotificationModel(
        id: '3',
        title: isEnglish
            ? 'Reminder: Update Personal Data'
            : 'تذكير: تحديث البيانات الشخصية',
        description: isEnglish
            ? 'Please review and update your personal information'
            : 'يرجى مراجعة وتحديث بياناتك الشخصية',
        time: isEnglish ? 'Yesterday' : 'أمس',
        type: NotificationType.warning,
        icon: Icons.warning,
        iconColor: Colors.orange,
      ),
      NotificationModel(
        id: '4',
        title: isEnglish ? 'Need Help?' : 'هل تحتاج إلى مساعدة؟',
        description: isEnglish
            ? 'Contact HR Department'
            : 'تواصل مع قسم الموارد البشرية',
        time: '',
        type: NotificationType.help,
        icon: Icons.help,
        iconColor: Colors.purple,
      ),
    ];
  }
}
