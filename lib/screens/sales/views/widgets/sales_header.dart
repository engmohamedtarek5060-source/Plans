import 'package:flutter/material.dart';

class SalesHeader extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNewInvoicePressed;

  const SalesHeader({
    super.key,
    required this.isEnglish,
    this.onBackPressed,
    this.onNewInvoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الزر الأيسر: فاتورة جديدة
        if (onNewInvoicePressed != null)
          GestureDetector(
            onTap: onNewInvoicePressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange, Color(0xFFFF9800)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    isEnglish ? 'New Invoice' : 'فاتورة جديدة',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // المحتوى الأيمن: العنوان والعنوان الفرعي
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isEnglish ? 'Sales' : 'المبيعات',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),

              Text(
                isEnglish
                    ? 'Sales Invoices Management'
                    : 'إدارة فواتير المبيعات',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
