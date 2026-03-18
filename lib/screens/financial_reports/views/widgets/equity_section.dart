// screens/financial_reports/views/widgets/equity_section.dart
import 'package:flutter/material.dart';

class EquitySection extends StatelessWidget {
  final bool isEnglish;

  const EquitySection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // أصفر فاتح جداً
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // عنوان حقوق الملكية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '417,180 SAR' : '٤١٧٬١٨٠ ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Row(
                children: [
                  Text(
                    isEnglish ? "Owner's Equity" : 'حقوق الملكية',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.attach_money,
                    color: Colors.orange,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // البنود
          _buildEquityItem(
            label: isEnglish ? 'Capital' : 'رأس المال',
            value: isEnglish ? '300,000 SAR' : '٣٠٠٬٠٠٠ ر.س',
          ),
          const SizedBox(height: 12),

          _buildEquityItem(
            label: isEnglish ? 'Retained Earnings' : 'الأرباح المحتجزة',
            value: isEnglish ? '117,180 SAR' : '١١٧٬١٨٠ ر.س',
          ),
        ],
      ),
    );
  }

  Widget _buildEquityItem({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
        ],
      ),
    );
  }
}
