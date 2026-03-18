import 'package:flutter/material.dart';

class MainInfoCard extends StatelessWidget {
  final bool isEnglish;
  final String currentDate;

  const MainInfoCard({
    super.key,
    required this.isEnglish,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Icon and date
          Expanded(
            child: Row(
              children: [
                Icon(Icons.bar_chart, color: const Color(0xFFE65100), size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    currentDate,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Right side: Active status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
            ),
            child: Text(
              isEnglish ? 'Active' : 'نشط',
              style: const TextStyle(
                color: Color(0xFF4CAF50),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
