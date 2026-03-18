// widgets/required_label.dart

import 'package:flutter/material.dart';

class RequiredLabel extends StatelessWidget {
  final String text;

  const RequiredLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
