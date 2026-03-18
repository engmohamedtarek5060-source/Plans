import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/Treasury/views/treasury_screen.dart';
import 'package:saudiaaaa/screens/Treasury/views/widgets/today_sections.dart';

class TodayTransactionsSection extends StatelessWidget {
  final bool isEnglish;

  const TodayTransactionsSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TodayReceiptsContainer(isEnglish: isEnglish)),
        const SizedBox(width: 16),
        Expanded(child: TodayPaymentsContainer(isEnglish: isEnglish)),
      ],
    );
  }
}
