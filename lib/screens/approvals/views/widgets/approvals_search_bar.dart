import 'package:flutter/material.dart';

class ApprovalsSearchBar extends StatelessWidget {
  final bool isEnglish;

  const ApprovalsSearchBar({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: Icon(Icons.search, color: Colors.grey[600], size: 20),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: isEnglish
                    ? 'Search for request or employee...'
                    : '...ابحث عن طلب أو موظف',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
