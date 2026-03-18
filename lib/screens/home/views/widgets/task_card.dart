import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/task_details_screen.dart';

class TaskCard extends StatelessWidget {
  final bool isEnglish;
  final Map<String, dynamic> task;
  final Function(String) onTaskCompleted; // ✅ إضافة الكولباك

  const TaskCard({
    super.key,
    required this.isEnglish,
    required this.task,
    required this.onTaskCompleted, // ✅ إضافة هذا
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // نستنى نتيجة صفحة التفاصيل
        final bool? taskCompleted = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TaskDetailsScreen(isEnglish: isEnglish, task: task),
          ),
        );

        // لو المهمة اكتملت، نستدعي الكولباك عشان تختفي
        if (taskCompleted == true) {
          onTaskCompleted(task['title']); // ✅ نمرر عنوان المهمة عشان نشيلها
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // السطر الأول: العنوان وعلامة عاجل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task['title'] ?? (isEnglish ? 'Untitled' : 'بلا عنوان'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (task['isUrgent'] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isEnglish ? 'Urgent' : 'عاجل',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // الوصف التفصيلي
            Text(
              isEnglish ? 'Detailed Description' : 'الوصف التفصيلي',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task['description'] ??
                  (isEnglish ? 'No description' : 'لا يوجد وصف'),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // المسؤول والموعد النهائي في سطرين
            Row(
              children: [
                Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${isEnglish ? 'Responsible' : 'المسؤول'}: ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Text(
                  task['assignedTo'] ?? (isEnglish ? 'Unassigned' : 'غير محدد'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey[400],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${isEnglish ? 'Deadline' : 'الموعد النهائي'}: ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Text(
                  task['dueDate'] ?? (isEnglish ? 'No date' : 'لا يوجد تاريخ'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // متعلم بـ / الشركة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.business_center,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${isEnglish ? 'Related to' : 'متعلم بـ'}: ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  Expanded(
                    child: Text(
                      task['company'] ??
                          (isEnglish ? 'No company' : 'لا توجد شركة'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
