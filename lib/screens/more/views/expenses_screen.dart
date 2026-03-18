// ==================== expenses_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/home_view.dart';
import 'package:saudiaaaa/screens/home/views/widgets/bottom_navigation_bar.dart';
import 'package:saudiaaaa/screens/more/views/expense_details_screen.dart'; // 👈 إضافة import

class ExpensesScreen extends StatefulWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const ExpensesScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  int _currentIndex = 4;

  void _onNavItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isEnglish: widget.isEnglish),
        ),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // ========== App Bar ==========
            _buildAppBar(),

            // ========== المحتوى الرئيسي ==========
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== عنوان الصفحة =====
                    _buildPageTitle(),

                    const SizedBox(height: 20),

                    // ===== قائمة المصروفات =====
                    _buildExpensesList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isEnglish: widget.isEnglish,
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  // ========== دالة بناء App Bar ==========
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // أيقونة الرجوع
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              widget.isEnglish ? Icons.arrow_back : Icons.arrow_forward,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
          // أيقونة الإشعارات
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.grey[700],
                  size: 24,
                ),
              ),
              if (widget.notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${widget.notificationCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== دالة بناء عنوان الصفحة ==========
  Widget _buildPageTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isEnglish ? 'Expenses' : 'المصروفات',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.isEnglish
              ? 'Company Expenses Management'
              : 'إدارة مصروفات الشركة',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // ========== دالة بناء قائمة المصروفات ==========
  Widget _buildExpensesList() {
    return Column(
      children: [
        // مصروف الإيجار
        _buildExpenseCard(
          amount: '50,000',
          month: widget.isEnglish ? 'January 2026' : 'يناير ٢٠٢٦',
          description: widget.isEnglish ? 'Office Rent -' : 'إيجار المكتب -',
          currency: widget.isEnglish ? 'SAR' : 'ريال',
          date: '٢٠٢٦/١/١',
          category: widget.isEnglish ? 'Rent' : 'إيجار',
          supplier: widget.isEnglish
              ? 'United Real Estate Co.'
              : 'شركة العقارات المتحدة',
          invoiceNumber: 'INV-2026-001',
          paymentMethod: widget.isEnglish ? 'Bank Transfer' : 'تحويل بنكي',
        ),

        const SizedBox(height: 12),

        // مصروف الكهرباء
        _buildExpenseCard(
          amount: '3,500',
          month: widget.isEnglish ? 'January' : 'يناير',
          description: widget.isEnglish
              ? 'Electricity Bill -'
              : 'فاتورة الكهرباء -',
          currency: widget.isEnglish ? 'SAR' : 'ريال',
          date: '٢٠٢٦/١/١٥',
          category: widget.isEnglish ? 'Utilities' : 'خدمات',
          supplier: widget.isEnglish
              ? 'Saudi Electricity Company'
              : 'الشركة السعودية للكهرباء',
          invoiceNumber: 'ELEC-202601',
          paymentMethod: widget.isEnglish ? 'Bank Transfer' : 'تحويل بنكي',
        ),

        const SizedBox(height: 12),

        // مصروف المياه
        _buildExpenseCard(
          amount: '850',
          month: widget.isEnglish ? 'January' : 'يناير',
          description: widget.isEnglish ? 'Water Bill -' : 'فاتورة المياه -',
          currency: widget.isEnglish ? 'SAR' : 'ريال',
          date: '٢٠٢٦/١/٢٠',
          category: widget.isEnglish ? 'Utilities' : 'خدمات',
          supplier: widget.isEnglish
              ? 'National Water Company'
              : 'الشركة الوطنية للمياه',
          invoiceNumber: 'WTR-2026-015',
          paymentMethod: widget.isEnglish ? 'Bank Transfer' : 'تحويل بنكي',
        ),

        const SizedBox(height: 12),

        // مصروف الإنترنت
        _buildExpenseCard(
          amount: '450',
          month: widget.isEnglish ? 'January' : 'يناير',
          description: widget.isEnglish
              ? 'Internet Bill -'
              : 'فاتورة الإنترنت -',
          currency: widget.isEnglish ? 'SAR' : 'ريال',
          date: '٢٠٢٦/١/٢٥',
          category: widget.isEnglish ? 'Services' : 'خدمات',
          supplier: widget.isEnglish ? 'STC' : 'الاتصالات السعودية',
          invoiceNumber: 'NET-2026-089',
          paymentMethod: widget.isEnglish ? 'Bank Transfer' : 'تحويل بنكي',
        ),

        const SizedBox(height: 12),

        // مصروف صيانة
        _buildExpenseCard(
          amount: '2,200',
          month: widget.isEnglish ? 'January' : 'يناير',
          description: widget.isEnglish ? 'Maintenance -' : 'صيانة -',
          currency: widget.isEnglish ? 'SAR' : 'ريال',
          date: '٢٠٢٦/١/٢٨',
          category: widget.isEnglish ? 'Maintenance' : 'صيانة',
          supplier: widget.isEnglish
              ? 'Technical Maintenance Co.'
              : 'شركة الصيانة الفنية',
          invoiceNumber: 'MNT-2026-042',
          paymentMethod: widget.isEnglish ? 'Bank Transfer' : 'تحويل بنكي',
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  // ========== دالة بناء بطاقة المصروف مع إضافة التنقل ==========
  Widget _buildExpenseCard({
    required String amount,
    required String month,
    required String description,
    required String currency,
    required String date,
    required String category,
    required String supplier,
    required String invoiceNumber,
    required String paymentMethod,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseDetailsScreen(
              isEnglish: widget.isEnglish,
              expenseNumber: invoiceNumber,
              expenseType: widget.isEnglish ? 'Expense' : 'مصروف',
              status: widget.isEnglish ? 'Under Review' : 'قيد المراجعة',
              totalAmount: '$amount $currency',
              category: category,
              date: date,
              paymentMethod: paymentMethod,
              reference: invoiceNumber,
              employeeName: widget.isEnglish ? 'Ahmed Mohammed' : 'أحمد محمد',
              employeePosition: widget.isEnglish
                  ? 'Operations Manager'
                  : 'مدير العمليات',
              notes: widget.isEnglish
                  ? 'Periodic maintenance for factory equipment - spare parts and repairs'
                  : 'صيانة دورية لأجهزة المصنع - قطع غيار وإصلاحات',
              attachments: ['invoice-1234.pdf', 'receipt-001.jpg'],
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // الصف الأول: المبلغ والشهر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الشهر على اليسار
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                // المبلغ على اليمين
                Text(
                  '$amount ${widget.isEnglish ? 'SAR' : 'ريال'}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // الوصف
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // التاريخ
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // خط فاصل
            Divider(color: Colors.grey.shade300, height: 1, thickness: 1),

            const SizedBox(height: 12),

            // معلومات المصروف
            Row(
              children: [
                // طريقة الدفع
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isEnglish ? 'Payment Method' : 'طريقة الدفع',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        paymentMethod,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

                // رقم الفاتورة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.isEnglish ? 'Invoice No.' : 'رقم الفاتورة',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        invoiceNumber,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                // المورد
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.isEnglish ? 'Supplier' : 'المورد',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        supplier,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // التصنيف
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getCategoryColor(category).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: _getCategoryColor(category),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ========== دالة مساعدة لألوان التصنيف ==========
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'إيجار':
      case 'Rent':
        return Colors.blue;
      case 'خدمات':
      case 'Utilities':
      case 'Services':
        return Colors.teal;
      case 'صيانة':
      case 'Maintenance':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}
