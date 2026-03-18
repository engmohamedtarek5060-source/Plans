// ==================== more_screen.dart (التحديث) ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/widgets/employee_card.dart';
import 'package:saudiaaaa/screens/more/views/widgets/more_header.dart';
import 'package:saudiaaaa/screens/more/views/widgets/subscription_card.dart';
import 'package:saudiaaaa/screens/more/views/widgets/operations_section.dart';
import 'package:saudiaaaa/screens/more/views/widgets/settings_section.dart';
import 'package:saudiaaaa/screens/more/views/widgets/support_section.dart';

class MoreScreen extends StatelessWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;
  final bool showAppBar;
  final Function(String) onLanguageSelected;

  const MoreScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 0,
    this.showAppBar = true,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MoreHeader(isEnglish: isEnglish),
            const SizedBox(height: 30),
            EmployeeCard(isEnglish: isEnglish),
            const SizedBox(height: 20),
            SubscriptionCard(isEnglish: isEnglish),
            const SizedBox(height: 20),
            // 👈 تمرير الباراميترات المطلوبة
            OperationsSection(
              isEnglish: isEnglish,
              selectedBranch: initialBranch,
              notificationCount: initialNotificationCount,
            ),
            const SizedBox(height: 20),
            SettingsSection(
              isEnglish: isEnglish,
              onLanguageSelected: onLanguageSelected,
            ),
            const SizedBox(height: 20),
            SupportSection(isEnglish: isEnglish),
          ],
        ),
      ),
    );
  }
}
