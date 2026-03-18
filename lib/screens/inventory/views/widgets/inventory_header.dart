import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/all_products_screen.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/add_product_service_screen.dart';

class InventoryHeader extends StatelessWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const InventoryHeader({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // العنوان الرئيسي
        Text(
          isEnglish ? 'Inventory' : 'المخزون',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        // النص الفرعي
        Text(
          isEnglish
              ? 'Inventory Management & Monitoring'
              : 'إدارة ومراقبة المخزون',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 24),

        // الكونتينرات
        Row(
          children: [
            // الكونتينر الأبيض (كل المنتجات) - قابل للنقر
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllProductsScreen(
                        isEnglish: isEnglish,
                        initialBranch: initialBranch,
                        initialNotificationCount: initialNotificationCount,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // الأيقونة (ثلاثة خطوط)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.segment,
                              color: Colors.orange,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // النص
                        Expanded(
                          child: Text(
                            isEnglish ? 'All Products' : 'كل المنتجات',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // الكونتينر البرتقالي (إضافة منتج/خدمة) - قابل للنقر
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductServiceScreen(
                        isEnglish: isEnglish,
                        initialBranch: initialBranch,
                        initialNotificationCount: initialNotificationCount,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.orange[400]!, Colors.orange[600]!],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // الأيقونة (علامة زائد)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // النص
                        Expanded(
                          child: Text(
                            isEnglish
                                ? 'Add Product/Service'
                                : 'إضافة منتج/خدمة',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
