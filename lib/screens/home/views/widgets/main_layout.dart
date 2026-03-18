import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/bottom_navigation_bar.dart';
import 'package:saudiaaaa/screens/home/views/widgets/home_app_bar.dart';

// ==================== Main Layout ====================
class MainLayout extends StatelessWidget {
  final Widget child;
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;
  final VoidCallback onBranchTap;
  final VoidCallback onNotificationsTap;
  final int currentIndex;
  final Function(int) onNavItemTapped;
  final bool showAppBar;

  const MainLayout({
    super.key,
    required this.child,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
    required this.onBranchTap,
    required this.onNotificationsTap,
    required this.currentIndex,
    required this.onNavItemTapped,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: showAppBar
          ? HomeAppBar(
              isEnglish: isEnglish,
              selectedBranch: selectedBranch,
              notificationCount: notificationCount,
              onBranchTap: onBranchTap,
              onNotificationsTap: onNotificationsTap,
            )
          : null,
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(
        isEnglish: isEnglish,
        currentIndex: currentIndex,
        onTap: onNavItemTapped,
      ),
    );
  }
}
