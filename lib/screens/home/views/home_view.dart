import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';
import 'package:saudiaaaa/screens/home/views/widgets/branch_sheet.dart';
import 'package:saudiaaaa/screens/home/views/widgets/home_body.dart';
import 'package:saudiaaaa/screens/approvals/views/approvals_screen.dart';
import 'package:saudiaaaa/screens/inventory/views/inventory_screen.dart';
import 'package:saudiaaaa/screens/more/views/more_screen_view.dart';
import 'package:saudiaaaa/screens/sales/views/sales_screen.dart';
import 'package:saudiaaaa/screens/treasury/views/treasury_screen.dart';
import 'package:saudiaaaa/screens/financial_reports/views/financial_reports_screen.dart'; // إضافة الاستيراد

// Main Home Screen Widget
class HomeScreen extends StatefulWidget {
  final bool isEnglish;

  const HomeScreen({super.key, required this.isEnglish});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _notificationCount = 5;
  String _selectedBranch = 'الفرع الرئيسي';
  bool _showBranchSheet = false;
  bool _isDateFormatInitialized = false;
  int _currentIndex = 0; // للتحكم في التبويب النشط

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('ar');
    await initializeDateFormatting('en');
    if (mounted) {
      setState(() {
        _isDateFormatInitialized = true;
      });
    }
  }

  void _openBranchSheet() {
    setState(() {
      _showBranchSheet = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => BranchSheet(
        isEnglish: widget.isEnglish,
        selectedBranch: _selectedBranch,
        onBranchSelected: (branchName) {
          setState(() {
            _selectedBranch = branchName;
          });
        },
      ),
    ).then((value) {
      setState(() {
        _showBranchSheet = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNotificationsTap() {
    // يمكنك إضافة منطق الإشعارات هنا
    print('Notifications tapped');
  }

  // دالة اختيار اللغة
  void _onLanguageSelected(String languageCode) {
    bool newIsEnglish = languageCode == 'en';

    // إذا كانت اللغة مختلفة عن الحالية، أعد بناء التطبيق
    if (newIsEnglish != widget.isEnglish) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isEnglish: newIsEnglish),
        ),
      );
    }
  }

  // دالة للتنقل إلى صفحة التقارير المالية
  void _navigateToFinancialReports() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinancialReportsScreen(
          isEnglish: widget.isEnglish,
          selectedBranch: _selectedBranch,
          notificationCount: _notificationCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isEnglish: widget.isEnglish,
      selectedBranch: _selectedBranch,
      notificationCount: _notificationCount,
      onBranchTap: _openBranchSheet,
      onNotificationsTap: _onNotificationsTap,
      currentIndex: _currentIndex,
      onNavItemTapped: _onItemTapped,
      child: _getScreenForIndex(_currentIndex),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeBody(
          isEnglish: widget.isEnglish,
          isDateFormatInitialized: _isDateFormatInitialized,
          selectedBranch: _selectedBranch, // تمرير الفرع المحدد
          notificationCount: _notificationCount, // تمرير عدد الإشعارات
        );
      case 1:
        return SalesScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          showAppBar: false,
        );
      case 2:
        return InventoryScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          initialNotificationCount: _notificationCount,
        );
      case 3:
        return TreasuryScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          initialNotificationCount: _notificationCount,
        );
      case 4:
        return MoreScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          showAppBar: false,
          onLanguageSelected: _onLanguageSelected,
        );
      default:
        return HomeBody(
          isEnglish: widget.isEnglish,
          isDateFormatInitialized: _isDateFormatInitialized,
          selectedBranch: _selectedBranch,
          notificationCount: _notificationCount,
        );
    }
  }

  Widget _buildComingSoonScreen({
    required IconData icon,
    required String title,
  }) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Icon(icon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.isEnglish ? 'Coming Soon' : 'قريباً',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
