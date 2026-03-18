// ==================== operations_section.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/financial_reports/views/general_accounts_screen.dart';
import 'package:saudiaaaa/screens/more/views/import_export_screen.dart';
import 'package:saudiaaaa/screens/more/views/suppliers_screen.dart';
import 'package:saudiaaaa/screens/more/views/expenses_screen.dart'; // 👈 إضافة import شاشة المصروفات

class OperationsSection extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const OperationsSection({
    super.key,
    required this.isEnglish,
    this.selectedBranch = 'الفرع الرئيسي',
    this.notificationCount = 0,
  });

  void _navigateToGeneralAccounts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralAccountsScreen(
          isEnglish: isEnglish,
          selectedBranch: selectedBranch,
          notificationCount: notificationCount,
          showAppBar: true,
        ),
      ),
    );
  }

  void _navigateToImportExport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImportExportScreen(
          isEnglish: isEnglish,
          selectedBranch: selectedBranch,
          notificationCount: notificationCount,
        ),
      ),
    );
  }

  void _navigateToSuppliers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuppliersScreen(
          isEnglish: isEnglish,
          selectedBranch: selectedBranch,
          notificationCount: notificationCount,
        ),
      ),
    );
  }

  // 👈 إضافة دالة التنقل إلى شاشة المصروفات
  void _navigateToExpenses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpensesScreen(
          isEnglish: isEnglish,
          selectedBranch: selectedBranch,
          notificationCount: notificationCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان "العمليات"
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 4),
          child: Text(
            isEnglish ? 'Operations' : 'العمليات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),

        // كونتينر العمليات
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // عنصر الحسابات العامة
              _buildOperationItem(
                context: context,
                icon: Icons.account_balance,
                label: isEnglish ? 'General Accounts' : 'الحسابات العامة',
                showDivider: true,
                onTap: () => _navigateToGeneralAccounts(context),
              ),

              // عنصر التصدير والاستيراد
              _buildOperationItem(
                context: context,
                icon: Icons.import_export,
                label: isEnglish ? 'Export & Import' : 'التصدير والاستيراد',
                showDivider: true,
                onTap: () => _navigateToImportExport(context),
              ),

              // عنصر الموردون
              _buildOperationItem(
                context: context,
                icon: Icons.local_shipping,
                label: isEnglish ? 'Suppliers' : 'الموردون',
                showDivider: true,
                onTap: () => _navigateToSuppliers(context),
              ),

              // عنصر أوامر الشراء
              _buildOperationItem(
                context: context,
                icon: Icons.shopping_cart,
                label: isEnglish ? 'Purchase Orders' : 'أوامر الشراء',
                showDivider: true,
                onTap: () {
                  print('Purchase Orders tapped');
                },
              ),

              // عنصر المصروفات 👈 مع إضافة التنقل
              _buildOperationItem(
                context: context,
                icon: Icons.receipt,
                label: isEnglish ? 'Expenses' : 'المصروفات',
                showDivider: false,
                onTap: () => _navigateToExpenses(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOperationItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool showDivider,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    isEnglish ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(icon, color: Colors.grey[600], size: 24),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: Colors.grey.shade200,
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
