import 'package:flutter/material.dart';

class SalesSearchBar extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onFilterTap;
  final Function(String)? onSearchChanged;

  const SalesSearchBar({
    super.key,
    required this.isEnglish,
    required this.onFilterTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // حاوية الفلتر
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
          child: InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[700]!, width: 1.2),
              ),
              child: const Center(
                child: Icon(Icons.filter_alt, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        // حاوية البحث
        Expanded(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 2,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[700]!, width: 1.2),
              ),
              child: Row(
                children: [
                  // أيقونة البحث
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 22,
                    ),
                  ),

                  // حقل البحث
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: isEnglish
                            ? 'Search in invoices...'
                            : 'بحث في الفواتير...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      onChanged: onSearchChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
