// screens/financial_reports/views/widgets/financial_reports_body.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/financial_reports/views/cash_flow_details_screen.dart';
import 'package:saudiaaaa/screens/financial_reports/views/sales_summary_details_screen.dart';
import 'financial_report_container.dart';
import '../trial_balance_details_screen.dart'; // إضافة الاستيراد

class FinancialReportsBody extends StatelessWidget {
  final bool isEnglish;

  const FinancialReportsBody({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // العنوان الرئيسي (على اليمين)
            Text(
              isEnglish ? 'Financial Reports' : 'التقارير المالية',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 4),

            // العنوان الفرعي (على اليمين)
            Text(
              isEnglish
                  ? 'Summaries and financial analysis'
                  : 'ملخصات وتحليلات مالية',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),

            // كونتينر الفترة (منفصل)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الكونتينر الأصفر (على اليسار)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isEnglish ? 'This Month' : 'هذا الشهر',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // الجزء الأيمن (أيقونة + نص الفترة)
                  Row(
                    children: [
                      Text(
                        isEnglish ? 'Period :' : 'الفترة :',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.assessment,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // كونتينر ميزان المراجعة (منفصل)
            // كونتينر ميزان المراجعة (منفصل)
            FinancialReportContainer(
              isEnglish: isEnglish,
              icon: Icons.bar_chart,
              iconColor: Colors.orange,
              circleColor: const Color(0xFFFFF9C4),
              mainText: isEnglish ? 'Trial Balance' : 'ميزان المراجعة',
              subText: isEnglish
                  ? 'Accounts and balances summary'
                  : 'ملخص الحسابات والأرصدة',
              showArrow: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrialBalanceDetailsScreen(
                      // شيل const
                      isEnglish:
                          isEnglish, // <-- هنا استخدم isEnglish بتاع الصفحة
                      selectedBranch: '',
                      notificationCount: 0,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // كونتينر ملخص المبيعات (منفصل)
            FinancialReportContainer(
              isEnglish: isEnglish,
              icon: Icons.trending_up,
              iconColor: Colors.green,
              circleColor: const Color(0xFFE8F5E9),
              mainText: isEnglish ? 'Sales Summary' : 'ملخص المبيعات',
              subText: isEnglish
                  ? 'Sales performance and trends'
                  : 'أداء المبيعات والاتجاهات',
              showArrow: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalesSummaryDetailsScreen(
                      isEnglish: isEnglish,
                      selectedBranch: '',
                      notificationCount: 0,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // كونتينر التدفقات النقدية (منفصل)
            FinancialReportContainer(
              isEnglish: isEnglish,
              icon: Icons.attach_money,
              iconColor: Colors.blue,
              circleColor: const Color(0xFFE3F2FD),
              mainText: isEnglish ? 'Cash Flows' : 'التدفقات النقدية',
              subText: isEnglish
                  ? 'Revenues and expenses'
                  : 'الإيرادات والمصروفات',
              showArrow: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CashFlowDetailsScreen(
                      isEnglish: isEnglish,
                      selectedBranch: '',
                      notificationCount: 0,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // كونتينر الأرباح والخسائر (منفصل)
            FinancialReportContainer(
              isEnglish: isEnglish,
              icon: Icons.trending_down,
              iconColor: Colors.orange,
              circleColor: const Color(0xFFFFF9C4),
              mainText: isEnglish ? 'Profit & Loss' : 'الأرباح والخسائر',
              subText: isEnglish ? 'Coming soon' : 'قريباً',
              showArrow: true,
              isDisabled: true,
              onTap: null, // مش هيشتغل عشان isDisabled = true
            ),
            const SizedBox(height: 20),

            // سهم الرجوع للخلف (على اليسار في العربية)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: IconButton(
                  icon: Icon(
                    isEnglish ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.orange,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
