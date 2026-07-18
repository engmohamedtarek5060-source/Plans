class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.subtitle,
    required this.subtitleAr,
    required this.amount,
    required this.isIncome,
    required this.timestamp,
    required this.iconName,
  });

  final String id;
  final String title;
  final String titleAr;
  final String subtitle;
  final String subtitleAr;
  final double amount;
  final bool isIncome;
  final DateTime timestamp;
  final String iconName;
}
