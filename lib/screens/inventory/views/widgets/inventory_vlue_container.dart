import 'package:flutter/material.dart';

class InventoryValueContainer extends StatelessWidget {
  final bool isEnglish;

  const InventoryValueContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300, width: 1.5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade50,
            Colors.lightGreen.shade50,
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(top: 16, right: 16, child: InventoryValueIcon()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '581,220',
                  style: TextStyle(
                    fontSize: 24, // تقليل حجم الخط قليلاً
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4), // تقليل المسافة
                Text(
                  isEnglish ? 'Inventory Value (SAR)' : 'قيمة المخزون (ر.س)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    overflow: TextOverflow.ellipsis, // إضافة في حالة زيادة النص
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryValueIcon extends StatelessWidget {
  const InventoryValueIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: const Center(
        child: Icon(Icons.inventory, color: Colors.green, size: 22),
      ),
    );
  }
}
