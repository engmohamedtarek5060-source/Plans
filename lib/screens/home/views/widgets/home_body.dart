import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_indecatores.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_info_card.dart';
import 'package:saudiaaaa/screens/home/views/widgets/quickn_actions_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/welcom_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/sales_container.dart';
import 'package:saudiaaaa/screens/home/views/widgets/attention_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/quick_overview_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/quick_actions_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/performance_section.dart';
import 'package:saudiaaaa/screens/home/views/widgets/date_formatter.dart';

// screens/home/views/widgets/home_body.dart (تحديث)
class HomeBody extends StatelessWidget {
  final bool isEnglish;
  final bool isDateFormatInitialized;
  final String selectedBranch;
  final int notificationCount;

  const HomeBody({
    super.key,
    required this.isEnglish,
    required this.isDateFormatInitialized,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormatter.getCurrentDate(
      isEnglish,
      isDateFormatInitialized,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            WelcomeSection(
              isEnglish: isEnglish,
              selectedBranch: selectedBranch,
              notificationCount: notificationCount,
            ),

            const SizedBox(height: 15),

            // Main Info Card
            MainInfoCard(isEnglish: isEnglish, currentDate: currentDate),
            const SizedBox(height: 25),

            // Main Indicators
            MainIndicators(isEnglish: isEnglish),
            const SizedBox(height: 25),

            // Sales Container
            SalesContainer(isEnglish: isEnglish),
            const SizedBox(height: 30),

            // Quick Actions Section (القديم)
            QuicknActionsSection(isEnglish: isEnglish),
            const SizedBox(height: 30),

            // Attention Section
            AttentionSection(isEnglish: isEnglish),
            const SizedBox(height: 30),

            // Quick Overview Section
            QuickOverviewSection(isEnglish: isEnglish),
            const SizedBox(height: 30),

            // Quick Actions Section (الجديد - مع تمرير القيم)
            QuickActionsSection(
              isEnglish: isEnglish,
              selectedBranch: selectedBranch,
              notificationCount: notificationCount,
            ),
            const SizedBox(height: 30),

            // Performance Section
            PerformanceSection(isEnglish: isEnglish),
          ],
        ),
      ),
    );
  }
}
