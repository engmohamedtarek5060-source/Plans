// screens/financial_reports/views/widgets/accounting_equation_section.dart
import 'package:flutter/material.dart';

class AccountingEquationSection extends StatelessWidget {
  final bool isEnglish;

  const AccountingEquationSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA), // سماوي فاتح جداً
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // عنوان المعادلة المحاسبية
          Text(
            isEnglish ? 'Accounting Equation' : 'المعادلة المحاسبية',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Assets Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '542,180 SAR' : '٥٤٢٬١٨٠ ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                isEnglish ? 'Assets' : 'الأصول',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // = divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '=',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
            ],
          ),

          const SizedBox(height: 12),

          // Liabilities Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '125,000 SAR' : '١٢٥٬٠٠٠ ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                isEnglish ? 'Liabilities' : 'الخصوم',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // + divider
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  indent: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  endIndent: 50,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Equity Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '417,180 SAR' : '٤١٧٬١٨٠ ر.س',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                isEnglish ? "Owner's Equity" : 'حقوق الملكية',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
