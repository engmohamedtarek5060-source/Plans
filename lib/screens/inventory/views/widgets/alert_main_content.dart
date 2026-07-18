import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/alert_texts.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/orange_icon_container.dart';

class AlertMainContent extends StatelessWidget {
  final bool isEnglish;

  const AlertMainContent({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          AlertTexts(isEnglish: isEnglish),
          const SizedBox(width: 20),
          const OrangeIconContainer(),
        ],
      ),
    );
  }
}
