import 'package:flutter/material.dart';

class InvoicesHeader extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onNewInvoicePressed;
  final VoidCallback onViewAllPressed;

  const InvoicesHeader({
    super.key,
    required this.isEnglish,
    required this.onNewInvoicePressed,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: العنوان والزر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // العناوين على اليمين
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'Invoices' : 'الفواتير',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isEnglish
                          ? 'Sales Invoices Management'
                          : 'إدارة فواتير المبيعات',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // زر فاتورة جديدة على اليسار
              ElevatedButton.icon(
                onPressed: onNewInvoicePressed,
                icon: const Icon(Icons.add, size: 20),
                label: Text(isEnglish ? 'New Invoice' : 'فاتورة جديدة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // رابط عرض الكل (اختياري)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onViewAllPressed,
              child: Text(
                isEnglish ? 'View All' : 'عرض الكل',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
