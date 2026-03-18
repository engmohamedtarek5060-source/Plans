import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/invoice/views/widgets/step_indicator.dart';
import 'package:saudiaaaa/screens/invoice/views/widgets/product_card.dart';

class ProductSelectionScreen extends StatefulWidget {
  final bool isEnglish;
  final Function(Map<String, dynamic>) onNext; // تعديل هنا
  final VoidCallback onPrevious;

  const ProductSelectionScreen({
    super.key,
    required this.isEnglish,
    required this.onNext, // تعديل هنا
    required this.onPrevious,
  });

  @override
  State<ProductSelectionScreen> createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  String? _selectedProductId;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'منتج أ',
      'nameEn': 'Product A',
      'price': 2000.0,
      'quantity': 45,
      'icon': Icons.inventory_2_outlined,
    },
    {
      'id': '2',
      'name': 'منتج ب',
      'nameEn': 'Product B',
      'price': 3500.0,
      'quantity': 23,
      'icon': Icons.inventory_2_outlined,
    },
    {
      'id': '3',
      'name': 'منتج ج',
      'nameEn': 'Product C',
      'price': 1500.0,
      'quantity': 78,
      'icon': Icons.inventory_2_outlined,
    },
    {
      'id': '4',
      'name': 'منتج د',
      'nameEn': 'Product D',
      'price': 4200.0,
      'quantity': 12,
      'icon': Icons.inventory_2_outlined,
    },
    {
      'id': '5',
      'name': 'منتج ه',
      'nameEn': 'Product E',
      'price': 2800.0,
      'quantity': 34,
      'icon': Icons.inventory_2_outlined,
    },
    {
      'id': '6',
      'name': 'منتج و',
      'nameEn': 'Product F',
      'price': 5100.0,
      'quantity': 8,
      'icon': Icons.inventory_2_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Step Indicator
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: StepIndicator(currentStep: 2, isEnglish: widget.isEnglish),
        ),

        const Divider(thickness: 1, height: 1),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add Products Text
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.isEnglish ? 'Add Products' : 'إضافة منتجات',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

                const SizedBox(height: 16),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      // Search Icon
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'بحث عن منتج...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Products Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isSelected = _selectedProductId == product['id'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedProductId = product['id'];
                          });
                        },
                        child: ProductCard(
                          product: product,
                          isSelected: isSelected,
                          isEnglish: widget.isEnglish,
                        ),
                      );
                    },
                  ),
                ),

                // Navigation Buttons
                if (_selectedProductId != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        // Previous Button
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.onPrevious,
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.isEnglish ? 'Previous' : 'السابق',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Next Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // تمرير بيانات المنتج المحدد
                              final selectedProduct = products.firstWhere(
                                (p) => p['id'] == _selectedProductId,
                              );
                              widget.onNext(selectedProduct);
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.orange, Color(0xFFFFB74D)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  widget.isEnglish ? 'Next' : 'التالي',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
