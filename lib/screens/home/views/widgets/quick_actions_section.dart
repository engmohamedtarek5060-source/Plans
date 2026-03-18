import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/approvals/views/approvals_screen.dart';
import 'package:saudiaaaa/screens/financial_reports/views/financial_reports_screen.dart';
import 'package:saudiaaaa/screens/financial_reports/views/general_accounts_screen.dart';
import 'package:saudiaaaa/screens/inventory/views/inventory_screen.dart'; // إضافة import المخزون
import 'package:saudiaaaa/screens/sales/views/sales_screen.dart'; // إضافة import المبيعات
import 'package:saudiaaaa/screens/treasury/views/treasury_screen.dart'; // إضافة import النقدية والبنوك
import 'quick_action_container.dart';

class QuickActionsSection extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const QuickActionsSection({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title on the right
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isEnglish ? 'Quick Actions' : 'إجراءات سريعة',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // First Row: التقارير + الموافقات
        Row(
          children: [
            // First container - عرض التقارير
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinancialReportsScreen(
                        isEnglish: isEnglish,
                        selectedBranch: selectedBranch,
                        notificationCount: notificationCount,
                      ),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.yellow,
                  iconContainerColor: Colors.orange,
                  icon: Icons.bar_chart,
                  iconColor: Colors.white,
                  mainText: isEnglish ? 'View Reports' : 'التقارير',
                  mainTextColor: Colors.orange,
                  subText: isEnglish ? 'Financial Reports' : 'تقارير مالية',
                  circleNumber: '1',
                  isEnglish: isEnglish,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Second container - الموافقات
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ApprovalsScreen(isEnglish: isEnglish),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.yellow[100]!,
                  iconContainerColor: Colors.orange,
                  icon: Icons.checklist,
                  iconColor: Colors.orange,
                  mainText: isEnglish ? 'Approvals' : 'الموافقات',
                  mainTextColor: Colors.black,
                  subText: isEnglish ? 'Pending Requests' : 'طلبات معلقة',
                  circleNumber: '2',
                  isEnglish: isEnglish,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Second Row: المخزون + المبيعات
        Row(
          children: [
            // Third container - المخزون
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InventoryScreen(isEnglish: isEnglish),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.purple[100]!,
                  iconContainerColor: Colors.purple,
                  icon: Icons.inventory,
                  iconColor: Colors.white,
                  mainText: isEnglish ? 'Inventory' : 'المخزون',
                  mainTextColor: Colors.black,
                  subText: isEnglish ? 'Stock Management' : 'إدارة المخزون',
                  circleNumber: '3',
                  isEnglish: isEnglish,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Fourth container - المبيعات
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesScreen(isEnglish: isEnglish),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.green[100]!,
                  iconContainerColor: Colors.green,
                  icon: Icons.trending_up,
                  iconColor: Colors.white,
                  mainText: isEnglish ? 'Sales' : 'المبيعات',
                  mainTextColor: Colors.black,
                  subText: isEnglish ? 'Sales Report' : 'تقرير المبيعات',
                  circleNumber: '4',
                  isEnglish: isEnglish,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Third Row: الحسابات العامة + النقدية والبنوك
        Row(
          children: [
            // Fifth container - الحسابات العامة
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneralAccountsScreen(
                        isEnglish: isEnglish,
                        selectedBranch: selectedBranch,
                        notificationCount: notificationCount,
                      ),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.blue[100]!,
                  iconContainerColor: Colors.blue,
                  icon: Icons.people,
                  iconColor: Colors.white,
                  mainText: isEnglish ? 'General Accounts' : 'الحسابات العامة',
                  mainTextColor: Colors.black,
                  subText: isEnglish ? 'Accounts Management' : 'إدارة الحسابات',
                  circleNumber: '5',
                  isEnglish: isEnglish,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Sixth container - النقدية والبنوك
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TreasuryScreen(isEnglish: isEnglish),
                    ),
                  );
                },
                child: QuickActionContainer(
                  containerColor: Colors.teal[100]!,
                  iconContainerColor: Colors.teal,
                  icon: Icons.account_balance,
                  iconColor: Colors.white,
                  mainText: isEnglish ? 'Cash & Banks' : 'النقدية والبنوك',
                  mainTextColor: Colors.black,
                  subText: isEnglish ? 'Cash Management' : 'إدارة النقدية',
                  circleNumber: '6',
                  isEnglish: isEnglish,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
