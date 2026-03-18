import 'package:flutter/material.dart';

class OrangeIconContainer extends StatelessWidget {
  const OrangeIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: const Center(
        child: Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 32,
        ),
      ),
    );
  }
}
