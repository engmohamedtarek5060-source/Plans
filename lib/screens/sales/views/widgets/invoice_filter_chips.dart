import 'package:flutter/material.dart';

class InvoiceFilterChips extends StatelessWidget {
  final bool isEnglish;
  final int selectedFilter;
  final Function(int) onFilterSelected;

  const InvoiceFilterChips({
    super.key,
    required this.isEnglish,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    // الفلاتر الخمسة
    final List<FilterItem> filters = [
      FilterItem(
        label: isEnglish ? 'All' : 'الكل',
        count: 8,
        defaultColor: Colors.grey.shade300,
        selectedColor: Colors.orange,
        textColor: Colors.grey.shade700,
      ),
      FilterItem(
        label: isEnglish ? 'Draft' : 'مسودة',
        count: 1,
        defaultColor: Colors.grey.shade300,
        selectedColor: Colors.orange,
        textColor: Colors.grey.shade700,
      ),
      FilterItem(
        label: isEnglish ? 'Overdue' : 'متأخرة',
        count: 2,
        defaultColor: Colors.red.shade900,
        selectedColor: Colors.orange,
        textColor: Colors.white,
      ),
      FilterItem(
        label: isEnglish ? 'Pending' : 'معلق',
        count: 2,
        defaultColor: Colors.red.shade300,
        selectedColor: Colors.orange,
        textColor: Colors.white,
      ),
      FilterItem(
        label: isEnglish ? 'Paid' : 'مدفوع',
        count: 2,
        defaultColor: Colors.green,
        selectedColor: Colors.orange,
        textColor: Colors.white,
      ),
    ];

    return SizedBox(
      height: 80, // ارتفاع ثابت للـ Row
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = selectedFilter == index;
          final filter = filters[index];

          return GestureDetector(
            onTap: () => onFilterSelected(index),
            child: Container(
              width: 70, // عرض ثابت للكونتينر
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors
                          .orange
                          .shade50 // لون خلفية فاتح جداً عند الاختيار
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.orange : filter.defaultColor,
                  width: isSelected ? 2 : 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الرقم
                  Text(
                    filter.count.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.orange
                          : (filter.textColor == Colors.white
                                ? filter.defaultColor
                                : filter.textColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // النص
                  Text(
                    filter.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.orange
                          : (filter.textColor == Colors.white
                                ? filter.defaultColor
                                : filter.textColor),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterItem {
  final String label;
  final int count;
  final Color defaultColor;
  final Color selectedColor;
  final Color textColor;

  FilterItem({
    required this.label,
    required this.count,
    required this.defaultColor,
    required this.selectedColor,
    required this.textColor,
  });
}
