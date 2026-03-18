// ==================== Header Widget ====================
import 'package:flutter/material.dart';

class MoreHeader extends StatelessWidget {
  final bool isEnglish;

  const MoreHeader({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isEnglish ? 'More' : 'المزيد',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isEnglish ? 'Settings & Account' : 'الإعدادات والحساب',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
