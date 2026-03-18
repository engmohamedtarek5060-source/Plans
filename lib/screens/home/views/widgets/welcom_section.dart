// screens/home/views/widgets/welcom_section.dart (تحديث)
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/financial_reports/views/financial_reports_screen.dart';

class WelcomeSection extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch; // إضافة هذه الخاصية
  final int notificationCount; // إضافة هذه الخاصية

  const WelcomeSection({
    super.key,
    required this.isEnglish,
    required this.selectedBranch, // إضافة هذا
    required this.notificationCount, // إضافة هذا
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: const Color(0xFFFF9800),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEnglish ? 'Good Morning,' : 'صباح الخير,',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          isEnglish ? 'Ahmed' : 'أحمد',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isEnglish
                    ? 'Comprehensive overview of business performance'
                    : 'نظرة شاملة على أداء الأعمال',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                maxLines: 2,
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // Eye Icon Circle - مع onTap
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinancialReportsScreen(
                  isEnglish: isEnglish,
                  selectedBranch: selectedBranch,
                  notificationCount: notificationCount,
                ),
              ),
            );
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9C4).withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFF176).withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.remove_red_eye,
              color: Color(0xFFFF9800),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
