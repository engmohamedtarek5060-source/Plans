// Search Filter Bar Widget
import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final bool isEnglish;

  const SearchFilterBar({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            SearchField(isEnglish: isEnglish),
            FilterButton(),
          ],
        ),
      ),
    );
  }
}

// Search Field Widget
class SearchField extends StatelessWidget {
  final bool isEnglish;

  const SearchField({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: isEnglish ? 'Search...' : 'بحث...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: Icon(Icons.search, color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}

// Filter Button Widget
class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Icon(Icons.filter_list, color: Colors.white, size: 24),
      ),
    );
  }
}
