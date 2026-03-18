// قائمة المنتجات Widget
import 'package:flutter/material.dart';

class ProductsListSection extends StatelessWidget {
  final bool isEnglish;

  const ProductsListSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    // بيانات المنتجات (يمكن استبدالها ببيانات حقيقية)
    final List<Map<String, dynamic>> products = [
      {
        'name': 'منتج أ',
        'nameEn': 'Product A',
        'code': 'PDR-001',
        'category': 'إلكترونيات',
        'categoryEn': 'Electronics',
        'available': 45,
        'total': 20,
        'status': 'جيد',
        'statusEn': 'Good',
        'value': 38546,
      },
      {
        'name': 'منتج ب',
        'nameEn': 'Product B',
        'code': 'PDR-002',
        'category': 'ملابس',
        'categoryEn': 'Clothing',
        'available': 10,
        'total': 50,
        'status': 'منخفض',
        'statusEn': 'Low',
        'value': 22480,
      },
      {
        'name': 'منتج ج',
        'nameEn': 'Product C',
        'code': 'PDR-003',
        'category': 'أثاث',
        'categoryEn': 'Furniture',
        'available': 0,
        'total': 15,
        'status': 'نافذ',
        'statusEn': 'Out of Stock',
        'value': 12500,
      },
      {
        'name': 'منتج د',
        'nameEn': 'Product D',
        'code': 'PDR-004',
        'category': 'أدوات',
        'categoryEn': 'Tools',
        'available': 5,
        'total': 100,
        'status': 'حرج',
        'statusEn': 'Critical',
        'value': 18900,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isEnglish ? 'Products List' : 'قائمة المنتجات',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          ...products
              .map(
                (product) =>
                    ProductItem(product: product, isEnglish: isEnglish),
              )
              .toList(),
        ],
      ),
    );
  }
}

// عنصر المنتج Widget
class ProductItem extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isEnglish;

  const ProductItem({
    super.key,
    required this.product,
    required this.isEnglish,
  });

  // دالة للحصول على لون الحالة
  Color _getStatusColor(String status) {
    switch (status) {
      case 'جيد':
        return Colors.green[300]!;
      case 'منخفض':
        return Colors.orange[300]!;
      case 'حرج':
        return Colors.red[300]!;
      case 'نافذ':
        return Colors.grey[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  // دالة للحصول على لون الحالة الداكن
  Color _getStatusDarkColor(String status) {
    switch (status) {
      case 'جيد':
        return Colors.green[600]!;
      case 'منخفض':
        return Colors.orange[600]!;
      case 'حرج':
        return Colors.red[600]!;
      case 'نافذ':
        return Colors.grey[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  // دالة للحصول على لون الشريط السفلي
  Color _getBottomBarColor(String status) {
    switch (status) {
      case 'جيد':
        return Colors.green[100]!;
      case 'منخفض':
        return Colors.orange[100]!;
      case 'حرج':
        return Colors.red[100]!;
      case 'نافذ':
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  // دالة للحصول على أيقونة الحالة
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'جيد':
        return Icons.check_circle;
      case 'منخفض':
        return Icons.warning;
      case 'حرج':
        return Icons.error;
      case 'نافذ':
        return Icons.remove_circle;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = product['status'];
    final statusColor = _getStatusColor(status);
    final statusDarkColor = _getStatusDarkColor(status);
    final bottomBarColor = _getBottomBarColor(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // الشريط السفلي
          if (status != 'نافذ')
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: bottomBarColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // الدائرة مع الأيقونة
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(statusIcon, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // المعلومات النصية
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isEnglish ? product['nameEn'] : product['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product['code']} • ${isEnglish ? product['categoryEn'] : product['category']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isEnglish
                                ? 'Available Quantity'
                                : 'الكمية المتوفرة',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${product['available']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '/${product['total']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // القسم العلوي الأيسر
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // حاوية الحالة
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(statusIcon, color: Colors.white, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            isEnglish ? product['statusEn'] : product['status'],
                            style: TextStyle(
                              color: statusDarkColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // القيمة المالية
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isEnglish ? 'Value' : 'القيمة',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product['value'].toString()} ${isEnglish ? 'SAR' : 'ر.س'}',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
