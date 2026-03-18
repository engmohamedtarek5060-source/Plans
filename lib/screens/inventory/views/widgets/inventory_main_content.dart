import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/alert_container.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_content.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_search_filter_bar.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_statu_section.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/products_list_section.dart';

class InventoryMainContent extends StatelessWidget {
  final bool isEnglish;
  final String selectedStatus;
  final int selectedFilter;
  final String initialBranch;
  final int initialNotificationCount;
  final Function(String) onStatusSelected;
  final VoidCallback onFilterTap;
  final Function(String)? onSearchChanged;

  const InventoryMainContent({
    super.key,
    required this.isEnglish,
    required this.selectedStatus,
    required this.selectedFilter,
    required this.onStatusSelected,
    required this.onFilterTap,
    this.onSearchChanged,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // محتوى المخزون العلوي
              InventoryContent(
                isEnglish: isEnglish,
                initialBranch: initialBranch,
                initialNotificationCount: initialNotificationCount,
              ),

              const SizedBox(height: 20),

              // حاوية التنبيهات
              AlertContainer(isEnglish: isEnglish),

              const SizedBox(height: 30),

              // قسم حالة المخزون
              StatusBoxesSection(
                isEnglish: isEnglish,
                selectedStatus: selectedStatus,
                onStatusSelected: onStatusSelected,
              ),

              const SizedBox(height: 30),

              // شريط البحث والتصفية
              InventorySearchFilterBar(
                isEnglish: isEnglish,
                onFilterTap: onFilterTap,
                onSearchChanged: onSearchChanged,
              ),

              const SizedBox(height: 30),

              // قائمة المنتجات
              ProductsListSection(isEnglish: isEnglish),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
