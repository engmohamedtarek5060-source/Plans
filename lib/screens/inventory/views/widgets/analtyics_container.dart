import 'package:flutter/material.dart';

class AnalyticsContainer extends StatelessWidget {
  final bool isEnglish;

  const AnalyticsContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.yellow.shade50, Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(top: 16, right: 16, child: AnalyticsIcon()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '8',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4), // تقليل المسافة
                Text(
                  isEnglish ? 'Total Analytics' : 'إجمالي التحليلات',
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

class AnalyticsIcon extends StatelessWidget {
  const AnalyticsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange, width: 1.5),
      ),
      child: const Center(
        child: Icon(Icons.analytics, color: Colors.orange, size: 22),
      ),
    );
  }
}
