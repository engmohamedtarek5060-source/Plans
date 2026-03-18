import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/sales/views/invoices_management_screen.dart'; // استيراد شاشة الفواتير

class AttentionSecondContainer extends StatelessWidget {
  final bool isEnglish;

  const AttentionSecondContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال لشاشة إدارة الفواتير مع فلتر المتأخرة (index 2)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoicesManagementScreen(
              isEnglish: isEnglish,
              initialBranch: 'الفرع الرئيسي',
              initialNotificationCount: 5,
              initialFilterIndex: 2, // فلتر المتأخرة
            ),
          ),
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.red[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // الدائرة الحمراء فوق البوردر
            Positioned(
              top: -15,
              left: 12,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // المحتوى الرئيسي
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الأيقونة العلوية
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // النصوص
                  Text(
                    isEnglish ? 'Late Invoices' : 'فواتير متأخرة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '28,500',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
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
