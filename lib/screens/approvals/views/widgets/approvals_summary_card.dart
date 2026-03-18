import 'package:flutter/material.dart';

class ApprovalsSummaryCard extends StatelessWidget {
  final bool isEnglish;

  const ApprovalsSummaryCard({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isEnglish ? '3 Pending Requests' : '٣ طلبات معلقة',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 4),
                Text(
                  isEnglish
                      ? 'Need review and decision'
                      : 'تحتاج إلى مراجعة واتخاذ قرار',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.error_outline, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
