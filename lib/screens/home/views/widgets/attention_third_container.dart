import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/inventory_screen.dart'; // إضافة الاستيراد

class AttentionThirdContainer extends StatelessWidget {
  final bool isEnglish;

  const AttentionThirdContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال لشاشة المخزون
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryScreen(
              isEnglish: isEnglish,
              initialBranch: 'الفرع الرئيسي',
              initialNotificationCount: 5,
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
            colors: [Colors.yellow[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // الدائرة البرتقالية فوق البوردر
            Positioned(
              top: -15,
              left: 12,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    '7',
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
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // النصوص
                  Text(
                    isEnglish ? 'Inventory Alerts' : 'تنبيهات المخزون',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEnglish ? 'Low Product' : 'منتج منخفض',
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
