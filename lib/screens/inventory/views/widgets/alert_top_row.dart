import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/exclamation_mark_box.dart';

class AlertTopRow extends StatelessWidget {
  final bool isEnglish;

  const AlertTopRow({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEnglish ? 'Show' : 'عرض',
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const ExclamationMarkBox(),
        ],
      ),
    );
  }
}
