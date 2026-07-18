// screens/financial_reports/views/widgets/main_indicators.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/Treasury/views/treasury_screen.dart';
import 'package:saudiaaaa/screens/financial_reports/views/financial_reports_screen.dart'; // إضافة الاستيراد

class MainIndicators extends StatelessWidget {
  final bool isEnglish;

  const MainIndicators({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان وعرض الكل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? 'Main Indicators' : 'المؤشرات الرئيسية',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinancialReportsScreen(
                        isEnglish: isEnglish,
                        selectedBranch: 'الفرع الرئيسي',
                        notificationCount: 0,
                      ),
                    ),
                  );
                },
                child: Text(
                  isEnglish ? 'View All' : 'عرض الكل',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // الكونتينر الرئيسي (قابل للضغط)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TreasuryScreen(
                    isEnglish: isEnglish,
                    initialBranch: 'الفرع الرئيسي',
                    initialNotificationCount: 0,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE8F5E9), // أخضر فاتح جداً
                    Color(0xFFF1F8E9), // أخضر فاتح
                    Colors.white,
                    Color(0xFFFFF8E1), // أصفر فاتح
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الصف العلوي: الأيقونات والنصوص
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // الجزء الأيمن: أيقونة السهم (الشمال)
                        Icon(Icons.trending_up, color: Colors.green, size: 28),

                        // الجزء الأيسر: أيقونة المحفظة والنص (اليمين)
                        Row(
                          children: [
                            Text(
                              isEnglish ? 'Financial Status' : 'الوضع المالي',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: Color(0xFF4CAF50),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // المبلغ الرئيسي
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '45,250',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isEnglish ? 'SAR' : 'ر.س',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // الزيادة والتاريخ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // نص الأمس
                        Text(
                          isEnglish ? 'From Yesterday' : 'عن الأمس',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // المبلغ الزائد
                        Text(
                          isEnglish ? '+2500 SAR' : '+2500 ر.س',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // سهم الزيادة
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                          size: 14,
                        ),
                      ],
                    ),

                    // الخط الفاصل
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),

                    // التوزيعات: الخزينة، البنك، الشبكات
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // الخزينة
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isEnglish ? 'Treasury' : 'الخزينة',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '18,500',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // البنك
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isEnglish ? 'Bank' : 'البنك',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '26,750',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // الشبكات
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isEnglish ? 'Networks' : 'شبكات',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '3',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
