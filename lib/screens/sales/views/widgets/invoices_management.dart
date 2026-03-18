import 'package:flutter/material.dart';

class InvoicesManagementHeader extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onNewInvoicePressed;

  const InvoicesManagementHeader({
    super.key,
    required this.isEnglish,
    required this.onNewInvoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان وزرار الفاتورة الجديدة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  Text(
                    isEnglish
                        ? 'Sales Invoices Management'
                        : 'إدارة فواتير المبيعات',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onNewInvoicePressed,
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  isEnglish ? 'New Invoice' : 'فاتورة جديدة',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // الكارد المتدرج
          _buildGradientCard(),
        ],
      ),
    );
  }

  Widget _buildGradientCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF9E6), // أصفر فاتح جداً
            Color(0xFFFFFFFF), // أبيض
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // الصف العلوي: إجمالي الفواتير والدائرة البرتقالية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnglish ? 'Total Invoices' : 'إجمالي الفواتير',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '108,850 ر.س',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isEnglish ? '6 Active Invoices' : '6 فاتورة نشطة',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.receipt, color: Colors.white, size: 24),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Divider
          Divider(color: Colors.grey[300], thickness: 1),

          const SizedBox(height: 16),

          // الصف السفلي: مدفوع ومعلق
          Row(
            children: [
              // مدفوع
              Expanded(
                child: _buildStatusCard(
                  icon: Icons.check_circle,
                  label: isEnglish ? 'Paid' : 'مدفوع',
                  value: '18,700 ر.س',
                  color: Colors.green,
                  backgroundColor: Colors.green.shade50,
                ),
              ),
              const SizedBox(width: 12),

              // معلق
              Expanded(
                child: _buildStatusCard(
                  icon: Icons.access_time,
                  label: isEnglish ? 'Pending' : 'معلق',
                  value: '90,150 ر.س',
                  color: Colors.orange,
                  backgroundColor: Colors.orange.shade50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
