import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/add_expense/views/add_expense_screen.dart';
import 'package:saudiaaaa/screens/inventory/views/all_products_screen.dart';
import 'package:saudiaaaa/screens/invoice/views/add_invoice_screen.dart';
import 'package:saudiaaaa/screens/sales/views/customers_management_screen.dart';

class QuicknActionsSection extends StatelessWidget {
  final bool isEnglish;

  const QuicknActionsSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              isEnglish ? 'Quick Actions' : 'إجراءات سريعة',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),

        // الصف الأول
        Row(
          children: [
            Expanded(
              child: ActionContainer(
                icon: Icons.receipt_long,
                label: isEnglish ? 'Add Invoice' : 'إضافة فاتورة',
                gradientColors: [const Color(0xFFC8E6C9), Colors.white],
                isEnglish: isEnglish,
                iconColor: const Color(0xFF2E7D32),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddInvoiceScreen(isEnglish: isEnglish),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionContainer(
                icon: Icons.people_outline,
                label: isEnglish ? 'Customers' : 'العملاء',
                gradientColors: [const Color(0xFFFFF9C4), Colors.white],
                isEnglish: isEnglish,
                iconColor: const Color(0xFFF57F17),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomersManagementScreen(
                        isEnglish: isEnglish,
                        initialBranch: 'الفرع الرئيسي',
                        initialNotificationCount: 5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // الصف الثاني
        Row(
          children: [
            Expanded(
              child: ActionContainer(
                icon: Icons.credit_card,
                label: isEnglish ? 'Add Expense' : 'إضافة مصروف',
                gradientColors: [const Color(0xFFFFF0B2), Colors.white],
                isEnglish: isEnglish,
                iconColor: const Color(0xFFF57F17),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddExpenseScreen(isEnglish: isEnglish),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionContainer(
                icon: Icons.inventory_2_outlined,
                label: isEnglish ? 'Products' : 'المنتجات',
                gradientColors: [const Color(0xFFFFE0B2), Colors.white],
                isEnglish: isEnglish,
                iconColor: const Color(0xFFBF360C),
                onTap: () {
                  // ✅ التنقل إلى شاشة AllProductsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllProductsScreen(isEnglish: isEnglish),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ActionContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> gradientColors;
  final bool isEnglish;
  final Color iconColor;
  final VoidCallback onTap;

  const ActionContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.gradientColors,
    required this.isEnglish,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(child: Icon(icon, size: 24, color: iconColor)),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
