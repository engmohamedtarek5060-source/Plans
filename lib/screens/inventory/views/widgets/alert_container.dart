import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/alert_main_content.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/alert_top_row.dart';

class AlertContainer extends StatelessWidget {
  final bool isEnglish;

  const AlertContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 2.5),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          children: [
            AlertTopRow(isEnglish: isEnglish),
            Container(height: 1, color: Colors.grey[300]),
            AlertMainContent(isEnglish: isEnglish),
          ],
        ),
      ),
    );
  }
}
