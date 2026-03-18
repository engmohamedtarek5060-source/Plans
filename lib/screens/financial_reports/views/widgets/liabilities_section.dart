// screens/financial_reports/views/widgets/liabilities_section.dart
import 'package:flutter/material.dart';

class LiabilitiesSection extends StatelessWidget {
  final bool isEnglish;

  const LiabilitiesSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE).withOpacity(0.7), // أحمر فاتح جداً
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // عنوان الخصوم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '125,000 SAR' : '١٢٥٬٠٠٠ ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Row(
                children: [
                  Text(
                    isEnglish ? 'Liabilities' : 'الخصوم',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.trending_down, color: Colors.red, size: 20),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // البنود
          _buildLiabilityItem(
            label: isEnglish ? 'Accounts Payable' : 'الموردون',
            value: isEnglish ? '85,000 SAR' : '٨٥٬٠٠٠ ر.س',
          ),
          const SizedBox(height: 12),

          _buildLiabilityItem(
            label: isEnglish ? 'Accrued Expenses' : 'مصروفات مستحقة',
            value: isEnglish ? '40,000 SAR' : '٤٠٬٠٠٠ ر.س',
          ),
        ],
      ),
    );
  }

  Widget _buildLiabilityItem({required String label, required String value}) {
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
