// Branch Item Widget
import 'package:flutter/material.dart';

class BranchItem extends StatelessWidget {
  final Map<String, dynamic> branch;
  final bool isSelected;
  final bool isEnglish;
  final VoidCallback onTap;

  const BranchItem({
    super.key,
    required this.branch,
    required this.isSelected,
    required this.isEnglish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFE65100) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Selected indicator
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF4CAF50),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  isEnglish ? 'Selected' : 'محدد',
                  style: const TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Location icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFFF3E0)
                    : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on,
                color: isSelected
                    ? const Color(0xFFE65100)
                    : const Color(0xFF757575),
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // Branch details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnglish ? branch['englishName'] : branch['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFFE65100)
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    branch['address'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
