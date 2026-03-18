// screens/financial_reports/views/widgets/financial_report_container.dart
import 'package:flutter/material.dart';

class FinancialReportContainer extends StatelessWidget {
  final bool isEnglish;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String mainText;
  final String subText;
  final bool showArrow;
  final bool isDisabled;
  final VoidCallback? onTap; // إضافة هذه الخاصية

  const FinancialReportContainer({
    super.key,
    required this.isEnglish,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.mainText,
    required this.subText,
    this.showArrow = true,
    this.isDisabled = false,
    this.onTap, // إضافة هذه الخاصية
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // السهم (على اليمين)
            if (showArrow)
              Icon(
                isEnglish ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                color: isDisabled ? Colors.grey[300] : Colors.orange,
                size: 16,
              ),
            if (showArrow) const SizedBox(width: 12),

            // النصوص (على اليمين)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDisabled ? Colors.grey : Colors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDisabled ? Colors.grey[400] : Colors.grey[600],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // الدائرة مع الأيقونة (على اليسار)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon, color: iconColor, size: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
