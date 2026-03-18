import 'package:flutter/material.dart';

class InvoicesSummaryCard extends StatelessWidget {
  final bool isEnglish;

  const InvoicesSummaryCard({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF9E6), // أصفر فاتح جداً
            Color(0xFFFFFFFF), // أبيض
          ],
        ),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // الصف العلوي: النصوص على اليمين والدائرة على اليسار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // النصوص على اليمين
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Total Invoices' : 'إجمالي الفواتير',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '١٠٨٬٨٥٠ ر.س',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish ? '6 Active Invoices' : '٦ فواتير نشطة',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                // الدائرة البرتقالية على اليسار
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.receipt,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Divider
            Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
            const SizedBox(height: 20),
            // الصف السفلي: كونتينرين جنب بعض
            Row(
              children: [
                // كونتينر المدفوع
                Expanded(
                  child: _buildStatusContainer(
                    backgroundColor: Colors.green.shade50,
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    label: isEnglish ? 'Paid' : 'مدفوع',
                    labelColor: Colors.green,
                    amount: '١٨٬٧٠٠ ر.س',
                  ),
                ),
                const SizedBox(width: 12),
                // كونتينر المعلق
                Expanded(
                  child: _buildStatusContainer(
                    backgroundColor: Colors.orange.shade50,
                    icon: Icons.access_time,
                    iconColor: Colors.orange,
                    label: isEnglish ? 'Pending' : 'معلق',
                    labelColor: Colors.orange,
                    amount: '٩٠٬١٥٠ ر.س',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusContainer({
    required Color backgroundColor,
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color labelColor,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
