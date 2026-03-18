import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/sales/views/sales_screen.dart';

class SalesContainer extends StatelessWidget {
  final bool isEnglish;

  const SalesContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال لشاشة المبيعات
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalesScreen(
              isEnglish: isEnglish,
              initialBranch: 'الفرع الرئيسي',
              initialNotificationCount: 5,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ===== كارت المبيعات =====
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFFF9C4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.orange.shade300,
                                  width: 1.5,
                                ),
                                color: Colors.orange,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),

                            Text(
                              isEnglish ? 'Today Sales' : 'مبيعات اليوم',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '12,450',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isEnglish ? 'SAR' : 'ر.س',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '+15%',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ===== كارت الهدف =====
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFE3F2FD),
                            Colors.white,
                            Colors.white,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blue.shade300,
                                  width: 1.5,
                                ),
                                color: const Color(0xFF2196F3),
                              ),
                              child: const Center(
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Positioned(
                                      top: 6,
                                      left: 6,
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Text(
                              isEnglish ? 'Monthly Target' : 'هدف الشهر',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const Text(
                              '67%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              '350,000 / 234,500',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            Text(
                              isEnglish ? 'Remaining 33%' : 'متبقي 33%',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
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
