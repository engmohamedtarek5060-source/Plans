import 'package:flutter/material.dart';

class QuickStatsRow extends StatelessWidget {
  final bool isEnglish;
  final int invoicesCount;
  final int customersCount;
  final VoidCallback onAddCustomer;
  final VoidCallback onInvoicesTap;
  final VoidCallback onCustomersTap; // ✅ إضافة هذا المتغير الجديد

  const QuickStatsRow({
    super.key,
    required this.isEnglish,
    required this.invoicesCount,
    required this.customersCount,
    required this.onAddCustomer,
    required this.onInvoicesTap,
    required this.onCustomersTap, // ✅ إضافة هذا
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // عدد الفواتير
        Expanded(
          child: GestureDetector(
            onTap: onInvoicesTap,
            child: _buildStatCard(
              icon: Icons.receipt_long,
              iconColor: Colors.orange,
              backgroundColor: Colors.orange.shade50,
              value: invoicesCount.toString(),
              label: isEnglish ? 'Invoices' : 'الفواتير',
            ),
          ),
        ),
        const SizedBox(width: 8),

        // عدد العملاء - ✅ إضافة GestureDetector هنا
        Expanded(
          child: GestureDetector(
            onTap: onCustomersTap, // ✅ عند الضغط يروح لشاشة العملاء
            child: _buildStatCard(
              icon: Icons.people,
              iconColor: Colors.blue,
              backgroundColor: Colors.blue.shade50,
              value: customersCount.toString(),
              label: isEnglish ? 'Customers' : 'العملاء',
            ),
          ),
        ),
        const SizedBox(width: 8),

        // إضافة عميل جديد
        Expanded(
          child: GestureDetector(
            onTap: onAddCustomer,
            child: _buildStatCard(
              icon: Icons.person_add,
              iconColor: Colors.green,
              backgroundColor: Colors.green.shade50,
              value: '',
              label: isEnglish ? 'Add Customer' : 'إضافة عميل',
              showValue: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String value,
    required String label,
    bool showValue = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              if (showValue) ...[
                const SizedBox(width: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
