// screens/treasury/views/treasury_screen.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/Treasury/views/widgets/accounts_section.dart';
import 'package:saudiaaaa/screens/Treasury/views/widgets/recent_transactions_section.dart';
import 'package:saudiaaaa/screens/Treasury/views/widgets/transction_section.dart';
import 'package:saudiaaaa/screens/treasury/views/widgets/total_balance_container.dart';

class TreasuryScreen extends StatelessWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;
  final bool showAppBar; // إضافة خاصية جديدة

  const TreasuryScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
    this.showAppBar = true, // افتراضياً يظهر الـ AppBar
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 70,
              leading: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    isEnglish ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                isEnglish ? 'Treasury & Banks' : 'الخزينة والبنوك',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          : null, // لو showAppBar = false، مفيش AppBar
      body: TreasuryContent(isEnglish: isEnglish),
    );
  }
}

class TreasuryContent extends StatelessWidget {
  final bool isEnglish;

  const TreasuryContent({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isEnglish ? 'Treasury & Banks' : 'الخزينة والبنوك',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Text(
                  isEnglish
                      ? 'Financial Accounts Management'
                      : 'إدارة الحسابات المالية',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 30),
            TotalBalancetContainer(isEnglish: isEnglish),
            const SizedBox(height: 30),
            TodayTransactionsSection(isEnglish: isEnglish),
            const SizedBox(height: 30),
            AccountsSection(isEnglish: isEnglish),
            const SizedBox(height: 30),
            RecentTransactionsSection(isEnglish: isEnglish),
          ],
        ),
      ),
    );
  }
}
