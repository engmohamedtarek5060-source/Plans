import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';
import 'package:saudiaaaa/screens/approvals/views/widgets/approvals_header.dart';
import 'package:saudiaaaa/screens/approvals/views/widgets/approvals_summary_card.dart';
import 'package:saudiaaaa/screens/approvals/views/widgets/approvals_search_bar.dart';
import 'package:saudiaaaa/screens/approvals/views/widgets/approvals_tabs.dart';
import 'package:saudiaaaa/screens/approvals/views/widgets/approvals_list.dart';

class ApprovalsScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const ApprovalsScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> {
  late String _selectedBranch;
  int _notificationCount = 0;
  int _currentIndex = 0;
  String _selectedTab = 'Pending';

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.initialBranch;
    _notificationCount = widget.initialNotificationCount;
  }

  void _onBranchTap() {
    print('Branch tap');
  }

  void _onNotificationsTap() {
    print('Notifications tap');
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index != 0) {
      Navigator.pop(context);
    }
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onTabChanged(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isEnglish: widget.isEnglish,
      selectedBranch: _selectedBranch,
      notificationCount: _notificationCount,
      onBranchTap: _onBranchTap,
      onNotificationsTap: _onNotificationsTap,
      currentIndex: _currentIndex,
      onNavItemTapped: _onNavItemTapped,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApprovalsHeader(
              isEnglish: widget.isEnglish,
              onBackPressed: _onBackPressed,
            ),
            const SizedBox(height: 25),
            ApprovalsSummaryCard(isEnglish: widget.isEnglish),
            const SizedBox(height: 25),
            ApprovalsSearchBar(isEnglish: widget.isEnglish),
            const SizedBox(height: 30),
            ApprovalsTabs(
              isEnglish: widget.isEnglish,
              onTabChanged: _onTabChanged,
              initialTab: _selectedTab,
            ),
            const SizedBox(height: 20),
            ApprovalsList(isEnglish: widget.isEnglish, status: _selectedTab),
          ],
        ),
      ),
    );
  }
}
