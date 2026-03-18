import 'package:flutter/material.dart';

class SalesStatisticsCard extends StatelessWidget {
  final bool isEnglish;

  const SalesStatisticsCard({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? 'Sales Statistics' : 'إحصائيات المبيعات',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isEnglish ? 'This Month' : 'هذا الشهر',
                  style: TextStyle(fontSize: 12, color: Colors.orange[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // إحصائيات سريعة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('85', isEnglish ? 'Invoices' : 'فاتورة'),
              _buildStatItem('₿42,500', isEnglish ? 'Revenue' : 'الإيرادات'),
              _buildStatItem('24', isEnglish ? 'Customers' : 'عميل'),
            ],
          ),

          const SizedBox(height: 12),

          // شريط تقدم بسيط
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? 'Target: 70%' : 'المستهدف: ٧٠٪',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                isEnglish ? 'Completed' : 'مكتمل',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
