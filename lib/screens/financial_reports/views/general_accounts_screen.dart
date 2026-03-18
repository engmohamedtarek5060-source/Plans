import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/home_view.dart';
import 'package:saudiaaaa/screens/home/views/widgets/bottom_navigation_bar.dart';

class GeneralAccountsScreen extends StatefulWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;
  final bool showAppBar;

  const GeneralAccountsScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
    this.showAppBar = true,
  });

  @override
  State<GeneralAccountsScreen> createState() => _GeneralAccountsScreenState();
}

class _GeneralAccountsScreenState extends State<GeneralAccountsScreen> {
  int _currentIndex = 4;
  String _selectedFilter = 'الكل';

  // Set لتتبع الحسابات المفتوحة
  final Set<String> _expandedAccounts = {};

  // نموذج البيانات الهرمية مع الحفاظ على نفس الأيقونة للمستويات المختلفة
  final List<AccountNode> accountTree = [
    // الأصول
    AccountNode(
      code: '1000',
      name: 'الأصول',
      nameEn: 'Assets',
      amount: 850000,
      icon: Icons.account_balance_wallet,
      iconColor: Colors.green,
      type: 'assets',
      children: [
        AccountNode(
          code: '1100',
          name: 'الأصول المتداولة',
          nameEn: 'Current Assets',
          amount: 450000,
          icon: Icons.account_balance_wallet, // نفس أيقونة الأصول
          iconColor: Colors.green, // نفس لون الأصول
          type: 'assets',
          children: [
            AccountNode(
              code: '1110',
              name: 'النقدية',
              nameEn: 'Cash',
              amount: 150000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
            AccountNode(
              code: '1120',
              name: 'البنوك',
              nameEn: 'Banks',
              amount: 200000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
            AccountNode(
              code: '1130',
              name: 'الذمم المدينة',
              nameEn: 'Accounts Receivable',
              amount: 100000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
          ],
        ),
        AccountNode(
          code: '1200',
          name: 'الأصول الثابتة',
          nameEn: 'Fixed Assets',
          amount: 400000,
          icon: Icons.account_balance_wallet, // نفس أيقونة الأصول
          iconColor: Colors.green, // نفس لون الأصول
          type: 'assets',
          children: [
            AccountNode(
              code: '1210',
              name: 'المباني',
              nameEn: 'Buildings',
              amount: 250000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
            AccountNode(
              code: '1220',
              name: 'الآلات والمعدات',
              nameEn: 'Equipment',
              amount: 100000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
            AccountNode(
              code: '1230',
              name: 'السيارات',
              nameEn: 'Vehicles',
              amount: 50000,
              icon: Icons.account_balance_wallet, // نفس الأيقونة
              iconColor: Colors.green,
              type: 'assets',
              isLeaf: true,
            ),
          ],
        ),
      ],
    ),

    // الخصوم
    AccountNode(
      code: '2000',
      name: 'الخصوم',
      nameEn: 'Liabilities',
      amount: 350000,
      icon: Icons.trending_down,
      iconColor: Colors.red,
      type: 'liabilities',
      children: [
        AccountNode(
          code: '2100',
          name: 'الخصوم المتداولة',
          nameEn: 'Current Liabilities',
          amount: 200000,
          icon: Icons.trending_down, // نفس أيقونة الخصوم
          iconColor: Colors.red, // نفس اللون
          type: 'liabilities',
          children: [
            AccountNode(
              code: '2110',
              name: 'الذمم الدائنة',
              nameEn: 'Accounts Payable',
              amount: 120000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'liabilities',
              isLeaf: true,
            ),
            AccountNode(
              code: '2120',
              name: 'القروض قصيرة الأجل',
              nameEn: 'Short-term Loans',
              amount: 80000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'liabilities',
              isLeaf: true,
            ),
          ],
        ),
        AccountNode(
          code: '2200',
          name: 'الخصوم طويلة الأجل',
          nameEn: 'Long-term Liabilities',
          amount: 150000,
          icon: Icons.trending_down, // نفس أيقونة الخصوم
          iconColor: Colors.red, // نفس اللون
          type: 'liabilities',
          children: [
            AccountNode(
              code: '2210',
              name: 'القروض طويلة الأجل',
              nameEn: 'Long-term Loans',
              amount: 150000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'liabilities',
              isLeaf: true,
            ),
          ],
        ),
      ],
    ),

    // حقوق الملكية
    AccountNode(
      code: '3000',
      name: 'حقوق الملكية',
      nameEn: 'Equity',
      amount: 500000,
      icon: Icons.account_balance,
      iconColor: Colors.blue,
      type: 'equity',
      children: [
        AccountNode(
          code: '3100',
          name: 'رأس المال',
          nameEn: 'Capital',
          amount: 400000,
          icon: Icons.account_balance, // نفس أيقونة حقوق الملكية
          iconColor: Colors.blue, // نفس اللون
          type: 'equity',
          isLeaf: true,
        ),
        AccountNode(
          code: '3200',
          name: 'الأرباح المحتجزة',
          nameEn: 'Retained Earnings',
          amount: 100000,
          icon: Icons.account_balance, // نفس الأيقونة
          iconColor: Colors.blue,
          type: 'equity',
          isLeaf: true,
        ),
      ],
    ),

    // الإيرادات
    AccountNode(
      code: '4000',
      name: 'الإيرادات',
      nameEn: 'Revenues',
      amount: 280000,
      icon: Icons.trending_up,
      iconColor: Colors.orange,
      type: 'revenues',
      children: [
        AccountNode(
          code: '4100',
          name: 'إيرادات المبيعات',
          nameEn: 'Sales Revenue',
          amount: 250000,
          icon: Icons.trending_up, // نفس أيقونة الإيرادات
          iconColor: Colors.orange, // نفس اللون
          type: 'revenues',
          isLeaf: true,
        ),
        AccountNode(
          code: '4200',
          name: 'إيرادات أخرى',
          nameEn: 'Other Revenue',
          amount: 30000,
          icon: Icons.trending_up, // نفس الأيقونة
          iconColor: Colors.orange,
          type: 'revenues',
          isLeaf: true,
        ),
      ],
    ),

    // المصروفات
    AccountNode(
      code: '5000',
      name: 'المصروفات',
      nameEn: 'Expenses',
      amount: 180000,
      icon: Icons.trending_down,
      iconColor: Colors.red,
      type: 'expenses',
      children: [
        AccountNode(
          code: '5100',
          name: 'مصروفات تشغيلية',
          nameEn: 'Operating Expenses',
          amount: 100000,
          icon: Icons.trending_down, // نفس أيقونة المصروفات
          iconColor: Colors.red, // نفس اللون
          type: 'expenses',
          children: [
            AccountNode(
              code: '5110',
              name: 'الرواتب',
              nameEn: 'Salaries',
              amount: 60000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'expenses',
              isLeaf: true,
            ),
            AccountNode(
              code: '5120',
              name: 'الإيجار',
              nameEn: 'Rent',
              amount: 25000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'expenses',
              isLeaf: true,
            ),
            AccountNode(
              code: '5130',
              name: 'المرافق',
              nameEn: 'Utilities',
              amount: 15000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'expenses',
              isLeaf: true,
            ),
          ],
        ),
        AccountNode(
          code: '5200',
          name: 'مصروفات إدارية',
          nameEn: 'Administrative Expenses',
          amount: 80000,
          icon: Icons.trending_down, // نفس أيقونة المصروفات
          iconColor: Colors.red, // نفس اللون
          type: 'expenses',
          children: [
            AccountNode(
              code: '5210',
              name: 'مصروفات مكتبية',
              nameEn: 'Office Expenses',
              amount: 30000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'expenses',
              isLeaf: true,
            ),
            AccountNode(
              code: '5220',
              name: 'مصروفات دعاية',
              nameEn: 'Marketing',
              amount: 50000,
              icon: Icons.trending_down, // نفس الأيقونة
              iconColor: Colors.red,
              type: 'expenses',
              isLeaf: true,
            ),
          ],
        ),
      ],
    ),
  ];

  List<AccountNode> get filteredAccounts {
    if (_selectedFilter == 'الكل' || _selectedFilter == 'All') {
      return accountTree;
    }

    switch (_selectedFilter) {
      case 'الملكية':
      case 'Ownership':
        return accountTree.where((a) => a.type == 'assets').toList();
      case 'الإيرادات':
      case 'Revenues':
        return accountTree.where((a) => a.type == 'revenues').toList();
      case 'المصروفات':
      case 'Expenses':
        return accountTree.where((a) => a.type == 'expenses').toList();
      default:
        return accountTree;
    }
  }

  void _toggleAccount(String code) {
    setState(() {
      if (_expandedAccounts.contains(code)) {
        _expandedAccounts.remove(code);
      } else {
        _expandedAccounts.add(code);
      }
    });
  }

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

  void _navigateToAccountDetails(AccountNode account) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountDetailsScreen(
          isEnglish: widget.isEnglish,
          account: account,
          parentAccount: _getParentAccount(account.code),
        ),
      ),
    );
  }

  AccountNode? _getParentAccount(String code) {
    for (var parent in accountTree) {
      for (var child in parent.children) {
        if (child.code == code) {
          return parent;
        }
        for (var grandChild in child.children) {
          if (grandChild.code == code) {
            return child;
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ========== الجزء العلوي البرتقالي ==========
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade800, Colors.orange.shade500],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // صف العنوان مع الأيقونات
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Text(
                          widget.isEnglish
                              ? 'General Accounts'
                              : 'الحسابات العامة',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // إضافة حساب جديد
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ===== كروت الإحصائيات =====
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatsCard(
                            title: widget.isEnglish
                                ? 'Net Income'
                                : 'صافي الدخل',
                            amount: '200,000',
                            icon: Icons.trending_up,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatsCard(
                            title: widget.isEnglish
                                ? 'Total Assets'
                                : 'إجمالي الأصول',
                            amount: '850,000',
                            icon: Icons.account_balance_wallet,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ===== الأرقام الثلاثة =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNumberItem(
                          '5',
                          widget.isEnglish ? 'Main Account' : 'حساب رئيسي',
                        ),
                        _buildNumberItem(
                          '11',
                          widget.isEnglish ? 'Sub Account' : 'حساب فرعي',
                        ),
                        _buildNumberItem(
                          '12',
                          widget.isEnglish ? 'Today Entry' : 'قيد اليوم',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ===== شريط البحث =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: widget.isEnglish
                          ? 'Search accounts...'
                          : 'بحث في الحسابات...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ===== أزرار الفلترة =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        label: widget.isEnglish ? 'Ownership' : 'الملكية',
                        icon: Icons.business,
                        isSelected:
                            _selectedFilter ==
                            (widget.isEnglish ? 'Ownership' : 'الملكية'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: widget.isEnglish ? 'Revenues' : 'الإيرادات',
                        icon: Icons.trending_up,
                        isSelected:
                            _selectedFilter ==
                            (widget.isEnglish ? 'Revenues' : 'الإيرادات'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: widget.isEnglish ? 'Expenses' : 'المصروفات',
                        icon: Icons.trending_down,
                        isSelected:
                            _selectedFilter ==
                            (widget.isEnglish ? 'Expenses' : 'المصروفات'),
                      ),
                      const SizedBox(width: 8),
                      _buildAllFilterChip(),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ===== قائمة الحسابات =====
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final account = filteredAccounts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildAccountTree(account, 0),
                  );
                }, childCount: filteredAccounts.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // إضافة قيد جديد
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.description, color: Colors.white, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: CustomBottomNavigationBar(
        isEnglish: widget.isEnglish,
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  // دالة بناء شجرة الحسابات
  Widget _buildAccountTree(AccountNode account, int depth) {
    final isExpanded = _expandedAccounts.contains(account.code);
    final hasChildren = account.children.isNotEmpty;
    final paddingLeft = depth * 20.0;

    return Column(
      children: [
        _buildAccountCard(account, depth, hasChildren),
        if (isExpanded && hasChildren)
          Padding(
            padding: EdgeInsets.only(left: paddingLeft + 16),
            child: Column(
              children: account.children
                  .map(
                    (child) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _buildAccountTree(child, depth + 1),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  // دالة بناء بطاقة الحساب
  Widget _buildAccountCard(AccountNode account, int depth, bool hasChildren) {
    return GestureDetector(
      onTap: () {
        if (hasChildren) {
          _toggleAccount(account.code);
        } else {
          _navigateToAccountDetails(account);
        }
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              // سهم التوسيع أو المسافة
              if (hasChildren)
                Icon(
                  _expandedAccounts.contains(account.code)
                      ? Icons.arrow_drop_down
                      : Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                )
              else
                const SizedBox(width: 16),

              const SizedBox(width: 8),

              // الدائرة مع الأيقونة (نفس الأيقونة واللون للحساب الرئيسي)
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: account.iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  account.icon, // نفس الأيقونة للحسابات الفرعية
                  color: account.iconColor, // نفس اللون
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              // النص الرئيسي
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // الكود والتصنيف
                    Row(
                      children: [
                        Text(
                          account.code,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (account.children.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${account.children.length} ${widget.isEnglish ? 'sub' : 'فرعي'}',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // اسم الحساب
                    Text(
                      widget.isEnglish ? account.nameEn : account.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // المبلغ
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${account.amount}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.isEnglish ? 'SAR' : 'ر.س',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isExpanded(String code) => _expandedAccounts.contains(code);

  Widget _buildStatsCard({
    required String title,
    required String amount,
    required IconData icon,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade400.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Icon(icon, color: Colors.white, size: 16),
            ],
          ),
          const Spacer(),
          Text(
            '$amount ر.س',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
          _expandedAccounts.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllFilterChip() {
    final isSelected = _selectedFilter == (widget.isEnglish ? 'All' : 'الكل');

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = widget.isEnglish ? 'All' : 'الكل';
          _expandedAccounts.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '5',
                  style: TextStyle(
                    color: isSelected ? Colors.orange : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              widget.isEnglish ? 'All' : 'الكل',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// نموذج بيانات الحساب
class AccountNode {
  final String code;
  final String name;
  final String nameEn;
  final double amount;
  final IconData icon;
  final Color iconColor;
  final String type;
  final List<AccountNode> children;
  final bool isLeaf;

  AccountNode({
    required this.code,
    required this.name,
    required this.nameEn,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.type,
    this.children = const [],
    this.isLeaf = false,
  });
}

// شاشة تفاصيل الحساب (بخلفية بيضاء)
class AccountDetailsScreen extends StatelessWidget {
  final bool isEnglish;
  final AccountNode account;
  final AccountNode? parentAccount;

  const AccountDetailsScreen({
    super.key,
    required this.isEnglish,
    required this.account,
    this.parentAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      body: CustomScrollView(
        slivers: [
          // ========== الجزء العلوي البرتقالي (نفس التصميم) ==========
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade800, Colors.orange.shade500],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // صف العنوان مع الرجوع فقط
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Text(
                        isEnglish ? account.nameEn : account.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48), // مساحة للموازنة
                    ],
                  ),

                  const SizedBox(height: 20),

                  // معلومات الحساب في الجزء العلوي
                  Row(
                    children: [
                      // أيقونة الحساب
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          account.icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // كود الحساب والرصيد
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${isEnglish ? 'Account Code' : 'كود الحساب'}: ${account.code}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${isEnglish ? 'Balance' : 'الرصيد'}: ${account.amount} ${isEnglish ? 'SAR' : 'ر.س'}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // ===== محتوى الشاشة الأبيض =====
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // مسار الحساب
                if (parentAccount != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.folder, color: account.iconColor, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            isEnglish
                                ? parentAccount!.nameEn
                                : parentAccount!.name,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEnglish ? account.nameEn : account.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),

                // بطاقة المعلومات الأساسية
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: account.iconColor.withOpacity(0.1),
                        child: Icon(
                          account.icon,
                          color: account.iconColor,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isEnglish ? account.nameEn : account.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${isEnglish ? 'Account Code' : 'كود الحساب'}: ${account.code}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoItem(
                            isEnglish ? 'Current Balance' : 'الرصيد الحالي',
                            '${account.amount} ${isEnglish ? 'SAR' : 'ر.س'}',
                            account.iconColor,
                          ),
                          _buildInfoItem(
                            isEnglish ? 'Account Type' : 'نوع الحساب',
                            isEnglish
                                ? account.type
                                : _getArabicType(account.type),
                            Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // عنوان الحركات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEnglish ? 'Recent Transactions' : 'آخر الحركات',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        isEnglish ? 'View All' : 'عرض الكل',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // قائمة الحركات
                _buildTransactionItem(
                  date: '2024-03-15',
                  description: isEnglish ? 'Opening Balance' : 'رصيد افتتاحي',
                  amount: account.amount,
                  type: 'credit',
                  iconColor: account.iconColor,
                ),
                _buildTransactionItem(
                  date: '2024-03-14',
                  description: isEnglish ? 'Purchase' : 'مشتريات',
                  amount: 5000,
                  type: 'debit',
                  iconColor: account.iconColor,
                ),
                _buildTransactionItem(
                  date: '2024-03-13',
                  description: isEnglish ? 'Payment' : 'دفعة',
                  amount: 3000,
                  type: 'credit',
                  iconColor: account.iconColor,
                ),
                _buildTransactionItem(
                  date: '2024-03-12',
                  description: isEnglish ? 'Expense' : 'مصروف',
                  amount: 2000,
                  type: 'debit',
                  iconColor: account.iconColor,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String date,
    required String description,
    required double amount,
    required String type,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == 'credit' ? Icons.arrow_upward : Icons.arrow_downward,
              color: type == 'credit' ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: type == 'credit' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                isEnglish ? 'SAR' : 'ر.س',
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getArabicType(String type) {
    switch (type) {
      case 'assets':
        return 'أصول';
      case 'liabilities':
        return 'خصوم';
      case 'equity':
        return 'حقوق ملكية';
      case 'revenues':
        return 'إيرادات';
      case 'expenses':
        return 'مصروفات';
      default:
        return type;
    }
  }
}
