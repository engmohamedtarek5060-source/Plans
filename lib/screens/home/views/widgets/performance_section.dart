import 'package:flutter/material.dart';
import 'performance_container.dart';

class PerformanceSection extends StatelessWidget {
  final bool isEnglish;

  const PerformanceSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [PerformanceContainer(isEnglish: isEnglish)],
    );
  }
}
