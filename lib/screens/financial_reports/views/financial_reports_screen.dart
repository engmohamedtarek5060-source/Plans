// screens/financial_reports/views/financial_reports_screen.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/bottom_navigation_bar.dart';
import 'package:saudiaaaa/screens/home/views/widgets/home_app_bar.dart';
import 'package:saudiaaaa/screens/financial_reports/views/widgets/financial_reports_body.dart';

class FinancialReportsScreen extends StatefulWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const FinancialReportsScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  State<FinancialReportsScreen> createState() => _FinancialReportsScreenState();
}

class _FinancialReportsScreenState extends State<FinancialReportsScreen> {
  int _currentIndex = 4; // المزيد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        isEnglish: widget.isEnglish,
        selectedBranch: widget.selectedBranch,
        notificationCount: widget.notificationCount,
        onBranchTap: () {
          // يمكن إضافة منطق تغيير الفرع هنا
        },
        onNotificationsTap: () {
          // يمكن إضافة منطق الإشعارات هنا
        },
      ),
      body: FinancialReportsBody(isEnglish: widget.isEnglish),
      bottomNavigationBar: CustomBottomNavigationBar(
        isEnglish: widget.isEnglish,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // يمكن إضافة التنقل هنا
        },
      ),
    );
  }
}
