import 'dart:ui';

import 'package:flutter/material.dart';

class AlertTexts extends StatelessWidget {
  final bool isEnglish;

  const AlertTexts({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isEnglish ? 'Inventory Alert' : 'تنبيه المخزون',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            isEnglish
                ? '5 products need reorder'
                : '5 منتج يحتاج إلى إعادة طلب',
            style: const TextStyle(color: Colors.orange, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

// Orange Icon Container Widget


// Stat