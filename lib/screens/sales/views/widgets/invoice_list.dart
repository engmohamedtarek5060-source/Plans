import 'package:flutter/material.dart';

class InvoiceList extends StatelessWidget {
  final bool isEnglish;
  final Function(Map<String, dynamic> invoice)? onInvoiceTap;

  const InvoiceList({super.key, required this.isEnglish, this.onInvoiceTap});

  @override
  Widget build(BuildContext context) {
    // قائمة الفواتير التجريبية
    final List<Map<String, dynamic>> invoices = [
      {
        'id': 'INV-001',
        'customer': 'مؤسسة النخبة',
        'date': '١٥ فبراير ٢٠٢٤',
        'amount': 8500,
        'status': 'مدفوع',
        'statusColor': Colors.green,
        'items': 3,
      },
      {
        'id': 'INV-002',
        'customer': 'شركة الواحة',
        'date': '١٤ فبراير ٢٠٢٤',
        'amount': 12500,
        'status': 'معلق',
        'statusColor': Colors.orange,
        'items': 5,
      },
      {
        'id': 'INV-003',
        'customer': 'مؤسسة الرمال الذهبية',
        'date': '١٣ فبراير ٢٠٢٤',
        'amount': 9500,
        'status': 'متأخر',
        'statusColor': Colors.red,
        'items': 2,
      },
      {
        'id': 'INV-004',
        'customer': 'برج اللؤلؤ',
        'date': '١٢ فبراير ٢٠٢٤',
        'amount': 16200,
        'status': 'مدفوع',
        'statusColor': Colors.green,
        'items': 4,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return GestureDetector(
          onTap: () => onInvoiceTap?.call(invoice),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // الصف العلوي: رقم الفاتورة والحالة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        invoice['id'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: invoice['statusColor'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: invoice['statusColor'],
                            width: 1,
                          ),
                        ),
                        child: Text(
                          invoice['status'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: invoice['statusColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // الصف الأوسط: العميل
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          invoice['customer'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // الصف السفلي: التاريخ وعدد المنتجات والمبلغ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // التاريخ
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            invoice['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      // عدد المنتجات والمبلغ
                      Row(
                        children: [
                          // عدد المنتجات
                          Row(
                            children: [
                              Icon(
                                Icons.inventory,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${invoice['items']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          // المبلغ
                          Text(
                            '${invoice['amount']} ر.س',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
