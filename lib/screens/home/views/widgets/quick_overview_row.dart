import 'package:flutter/material.dart';

class QuickOverviewRow extends StatelessWidget {
  final String leftText;
  final String leftSubText;
  final String rightText;
  final IconData rightIcon;
  final Color iconColor;
  final bool isEnglish;

  const QuickOverviewRow({
    super.key,
    required this.leftText,
    required this.leftSubText,
    required this.rightText,
    required this.rightIcon,
    this.iconColor = Colors.green,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Right side content (now on left)
        Row(
          children: [
            Text(
              rightText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(rightIcon, color: iconColor, size: 20),
          ],
        ),
        // Left side content (now on right)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              leftText,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              leftSubText,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
