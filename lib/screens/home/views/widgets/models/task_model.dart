class TaskModel {
  final String title;
  final String status; // 'موافقة', 'متأخر', إلخ
  final String description;
  final String value;
  final String assignedTo;
  final String dueDate;
  final String company;
  final bool isUrgent;

  TaskModel({
    required this.title,
    required this.status,
    required this.description,
    required this.value,
    required this.assignedTo,
    required this.dueDate,
    required this.company,
    this.isUrgent = false,
  });
}
