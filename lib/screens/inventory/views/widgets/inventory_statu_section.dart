// Status Section Title Widget
import 'package:flutter/material.dart';

class StatusSectionTitle extends StatelessWidget {
  final bool isEnglish;

  const StatusSectionTitle({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Text(
      isEnglish ? 'Inventory Status' : 'حالة المخزون',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }
}

// Status Boxes List Widget
class StatusBoxesList extends StatelessWidget {
  final bool isEnglish;
  final String selectedStatus;
  final Function(String) onStatusSelected;

  const StatusBoxesList({
    super.key,
    required this.isEnglish,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> statuses = [
      {
        'id': 'الكل',
        'nameEn': 'All',
        'nameAr': 'الكل',
        'count': 150,
        'color': Colors.black,
      },
      {
        'id': 'جيد',
        'nameEn': 'Good',
        'nameAr': 'جيد',
        'count': 120,
        'color': Colors.green[400]!,
      },
      {
        'id': 'منخفض',
        'nameEn': 'Low',
        'nameAr': 'منخفض',
        'count': 15,
        'color': Colors.orange[400]!,
      },
      {
        'id': 'حرج',
        'nameEn': 'Critical',
        'nameAr': 'حرج',
        'count': 10,
        'color': Colors.red[400]!,
      },
      {
        'id': '2',
        'nameEn': '2',
        'nameAr': '2',
        'count': 5,
        'color': Colors.grey[600]!,
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: statuses.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final status = statuses[index];
          return StatusBoxItem(
            status: status,
            isEnglish: isEnglish,
            isSelected: selectedStatus == status['id'],
            onTap: () => onStatusSelected(status['id']),
          );
        },
      ),
    );
  }
}

// Status Box Item Widget
class StatusBoxItem extends StatelessWidget {
  final Map<String, dynamic> status;
  final bool isEnglish;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusBoxItem({
    super.key,
    required this.status,
    required this.isEnglish,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${status['count']}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: status['color'],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEnglish ? status['nameEn'] : status['nameAr'],
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.black : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBoxesSection extends StatelessWidget {
  final bool isEnglish;
  final String selectedStatus;
  final Function(String) onStatusSelected;

  const StatusBoxesSection({
    super.key,
    required this.isEnglish,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StatusSectionTitle(isEnglish: isEnglish),
          const SizedBox(height: 16),
          StatusBoxesList(
            isEnglish: isEnglish,
            selectedStatus: selectedStatus,
            onStatusSelected: onStatusSelected,
          ),
        ],
      ),
    );
  }
}
