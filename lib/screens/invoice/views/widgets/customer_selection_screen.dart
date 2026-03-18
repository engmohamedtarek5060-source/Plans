import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/invoice/views/widgets/customer_card.dart';
import 'package:saudiaaaa/screens/invoice/views/widgets/step_indicator.dart';

class CustomerSelectionScreen extends StatefulWidget {
  final bool isEnglish;
  final Function(Map<String, dynamic>) onNext; // تعديل هنا

  const CustomerSelectionScreen({
    super.key,
    required this.isEnglish,
    required this.onNext, // تعديل هنا
  });

  @override
  State<CustomerSelectionScreen> createState() =>
      _CustomerSelectionScreenState();
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  String? _selectedCustomerId;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> customers = [
    {
      'id': '1',
      'name': 'شركة الأفق للتجارة',
      'nameEn': 'Al Ufuq Trading Company',
      'phone': '+966 50 123 4567',
      'previousBalance': 15000.0,
    },
    {
      'id': '2',
      'name': 'مؤسسة النخلة',
      'nameEn': 'Al Nakhlah Establishment',
      'phone': '+966 55 234 5678',
      'previousBalance': 8750.0,
    },
    {
      'id': '3',
      'name': 'شركة الخليج للإنشاءات',
      'nameEn': 'Al Khaleej Construction Co.',
      'phone': '+966 56 345 6789',
      'previousBalance': 23400.0,
    },
    {
      'id': '4',
      'name': 'مؤسسة السلام',
      'nameEn': 'Al Salam Establishment',
      'phone': '+966 54 456 7890',
      'previousBalance': 5200.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Step Indicator
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: StepIndicator(currentStep: 1, isEnglish: widget.isEnglish),
        ),

        const Divider(thickness: 1, height: 1),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Select Customer Text
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.isEnglish ? 'Select Customer' : 'اختر العميل',
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
                            hintText: 'بحث عن عميل...',
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

                // Customers List
                Expanded(
                  child: ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];
                      final isSelected = _selectedCustomerId == customer['id'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCustomerId = customer['id'];
                          });
                        },
                        child: CustomerCard(
                          customer: customer,
                          isSelected: isSelected,
                          isEnglish: widget.isEnglish,
                        ),
                      );
                    },
                  ),
                ),

                // Next Button
                if (_selectedCustomerId != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // تمرير بيانات العميل المحدد
                        final selectedCustomer = customers.firstWhere(
                          (c) => c['id'] == _selectedCustomerId,
                        );
                        widget.onNext(selectedCustomer);
                      },
                      child: Container(
                        width: double.infinity,
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
                              fontSize: 18,
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
        ),
      ],
    );
  }
}
