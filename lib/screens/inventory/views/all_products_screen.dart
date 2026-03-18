// screens/all_products/all_products_screen.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/add_product_service_screen.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/alert_container.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_search_filter_bar.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_statu_section.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/products_list_section.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_conatiner_row.dart';

class AllProductsScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const AllProductsScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  int _currentIndex = 1; // مؤشر المخزون
  String _selectedStatus = 'الكل';
  int _selectedFilter = 0;
  String _searchQuery = '';

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // هنا يمكن إضافة التنقل بناءً على index
  }

  void _onStatusSelected(String status) =>
      setState(() => _selectedStatus = status);

  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: widget.isEnglish
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: InventoryFilterBottomSheet(
            isEnglish: widget.isEnglish,
            initialSelectedFilter: _selectedFilter,
            onApplyFilter: (selected) {
              setState(() => _selectedFilter = selected);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isEnglish: widget.isEnglish,
      selectedBranch: widget.initialBranch,
      notificationCount: widget.initialNotificationCount,
      onBranchTap: () {
        // منطق اختيار الفرع
        print('Branch tapped');
      },
      onNotificationsTap: () {
        // منطق عرض الإشعارات
        print('Notifications tapped');
      },
      currentIndex: _currentIndex,
      onNavItemTapped: _onNavItemTapped,
      showAppBar: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // الهيدر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر الإضافة
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductServiceScreen(
                                isEnglish: widget.isEnglish,
                                initialBranch: widget.initialBranch,
                                initialNotificationCount:
                                    widget.initialNotificationCount,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Text(
                          widget.isEnglish ? 'Add' : 'إضافة',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // العنوان
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.isEnglish
                                ? 'Products & Services'
                                : 'المنتجات والخدمات',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.isEnglish
                                ? 'Inventory & Services Management'
                                : 'إدارة المخزون والخدمات',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Container Analytics Row (نفس اللي في المخزون)
                  SizedBox(
                    height: 180,
                    child: InventoryContainersRow(isEnglish: widget.isEnglish),
                  ),

                  const SizedBox(height: 20),

                  // Alert Container (نفس اللي في المخزون)
                  AlertContainer(isEnglish: widget.isEnglish),

                  const SizedBox(height: 30),

                  // Status Boxes Section (نفس اللي في المخزون)
                  StatusBoxesSection(
                    isEnglish: widget.isEnglish,
                    selectedStatus: _selectedStatus,
                    onStatusSelected: _onStatusSelected,
                  ),

                  const SizedBox(height: 30),

                  // Search and Filter Bar (نفس اللي في المخزون)
                  InventorySearchFilterBar(
                    isEnglish: widget.isEnglish,
                    onFilterTap: _onFilterTap,
                    onSearchChanged: _onSearchChanged,
                  ),

                  const SizedBox(height: 30),

                  // Products List Section (نفس اللي في المخزون)
                  ProductsListSection(isEnglish: widget.isEnglish),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
