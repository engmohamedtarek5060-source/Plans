import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final bool isEnglish;
  final Map<String, dynamic> task;

  const TaskDetailsScreen({
    super.key,
    required this.isEnglish,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEnglish ? 'Task Details' : 'تفاصيل المهمة',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // البطاقة الرئيسية
            Container(
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
                  // العنوان فقط (من غير حالة)
                  Text(
                    task['title'] ?? (isEnglish ? 'Untitled' : 'بلا عنوان'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // علامة عاجل إذا موجودة
                  if (task['isUrgent'] == true)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
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

                  const Divider(height: 24),

                  // الوصف التفصيلي
                  Text(
                    isEnglish ? 'Detailed Description' : 'الوصف التفصيلي',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task['description'] ??
                        (isEnglish ? 'No description' : 'لا يوجد وصف'),
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  if (task['value'] != null &&
                      task['value'].toString().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      task['value'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                  ],

                  const Divider(height: 24),

                  // المسؤول
                  _buildInfoRow(
                    icon: Icons.person_outline,
                    label: isEnglish ? 'Responsible' : 'المسؤول',
                    value:
                        task['assignedTo'] ??
                        (isEnglish ? 'Unassigned' : 'غير محدد'),
                    showSearchIcon: true,
                  ),
                  const SizedBox(height: 16),

                  // الموعد النهائي
                  _buildInfoRow(
                    icon: Icons.calendar_today,
                    label: isEnglish ? 'Deadline' : 'الموعد النهائي',
                    value:
                        task['dueDate'] ??
                        (isEnglish ? 'No date' : 'لا يوجد تاريخ'),
                  ),
                  const SizedBox(height: 16),

                  // متعلم بـ
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.business_center,
                          size: 20,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${isEnglish ? 'Related to' : 'متعلم بـ'}: ',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            task['company'] ??
                                (isEnglish ? 'No company' : 'لا توجد شركة'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // زر إكمال المهمة
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // إظهار Snackbar بنجاح
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            isEnglish
                                ? 'Task completed successfully!'
                                : 'تم إتمام المهمة بنجاح!',
                          ),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  // بعد ثانية نرجع للصفحة السابقة مع قيمة true
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(
                      context,
                      true,
                    ); // ✅ نرجع true عشان المهمة اكتملت
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  isEnglish ? 'Complete Task' : 'إكمال المهمة',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool showSearchIcon = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        if (showSearchIcon) ...[
          const SizedBox(width: 4),
          Icon(Icons.search, size: 16, color: Colors.grey[400]),
        ],
      ],
    );
  }
}
