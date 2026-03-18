import 'package:flutter/material.dart';
import 'attention_first_container.dart';
import 'attention_second_container.dart';
import 'attention_third_container.dart';
import 'attention_fourth_container.dart';
import 'attention_header.dart';

class AttentionSection extends StatelessWidget {
  final bool isEnglish;

  const AttentionSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        AttentionHeader(isEnglish: isEnglish),

        const SizedBox(height: 20),

        // First Row
        Row(
          children: [
            // First container - Pending Approvals
            Expanded(child: AttentionFirstContainer(isEnglish: isEnglish)),
            const SizedBox(width: 12),
            // Second container - Late Invoices
            Expanded(child: AttentionSecondContainer(isEnglish: isEnglish)),
          ],
        ),

        const SizedBox(height: 12),

        // Second Row
        Row(
          children: [
            // Third container - Inventory Alerts
            Expanded(child: AttentionThirdContainer(isEnglish: isEnglish)),
            const SizedBox(width: 12),
            // Fourth container - Upcoming Tasks
            Expanded(child: AttentionFourthContainer(isEnglish: isEnglish)),
          ],
        ),
      ],
    );
  }
}
