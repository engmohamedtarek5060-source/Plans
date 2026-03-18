import 'package:flutter/material.dart';
import 'quick_overview_row.dart';

class QuickOverviewContainer extends StatelessWidget {
  final bool isEnglish;

  const QuickOverviewContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // First Row: Best Selling Product
          QuickOverviewRow(
            leftText: isEnglish ? 'Best Selling Product' : 'أفضل منتج مبيعاً',
            leftSubText: isEnglish ? 'units today' : 'وحدة اليوم',
            rightText: '#245',
            rightIcon: Icons.trending_up,
            isEnglish: isEnglish,
          ),

          const SizedBox(height: 20),

          // Second Row: Average Invoice Value
          QuickOverviewRow(
            leftText: isEnglish
                ? 'Average Invoice Value'
                : 'متوسط قيمة الفاتورة',
            leftSubText: '+12% ' + (isEnglish ? 'from yesterday' : 'عن الأمس'),
            rightText: '1,840 ر.س',
            rightIcon: Icons.trending_up,
            isEnglish: isEnglish,
          ),

          const SizedBox(height: 20),

          // Third Row: New Customers
          QuickOverviewRow(
            leftText: isEnglish ? 'New Customers' : 'العملاء الجدد',
            leftSubText: isEnglish ? 'This week' : 'هذا الأسبوع',
            rightText: '7 ' + (isEnglish ? 'customers' : 'عملاء'),
            rightIcon: Icons.trending_up,
            isEnglish: isEnglish,
          ),
        ],
      ),
    );
  }
}
