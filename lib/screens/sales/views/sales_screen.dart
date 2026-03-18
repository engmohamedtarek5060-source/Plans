// screens/sales/views/sales_screen.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';
import 'package:saudiaaaa/screens/sales/views/add_customer_screen.dart';
import 'package:saudiaaaa/screens/sales/views/customers_management_screen.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/sales_header.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/quick_stats_row.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/sales_search_bar.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/filter_bottom_sheet.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/invoices_section.dart';
import 'package:saudiaaaa/screens/sales/views/invoices_management_screen.dart';

class SalesScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;
  final bool showAppBar;

  const SalesScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
    this.showAppBar = false,
  });

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late String _selectedBranch;
  int _notificationCount = 0;
  int _currentIndex = 0;
  int _selectedFilter = 0;
  String _searchQuery = '';
  bool _isBottomSheetOpen = false;

  // بيانات تجريبية
  final List<Map<String, dynamic>> invoices = [
    {
      'id': 'INV-001',
      'customer': 'مؤسسة النخبة',
      'date': '١٥ فبراير ٢٠٢٤',
      'amount': 8500,
      'status': 'مدفوع',
      'statusColor': Colors.green,
      'items': 3,
    },
    {
      'id': 'INV-002',
      'customer': 'شركة الواحة',
      'date': '١٤ فبراير ٢٠٢٤',
      'amount': 12500,
      'status': 'معلق',
      'statusColor': Colors.orange,
      'items': 5,
    },
    {
      'id': 'INV-003',
      'customer': 'مؤسسة الرمال الذهبية',
      'date': '١٣ فبراير ٢٠٢٤',
      'amount': 9500,
      'status': 'متأخر',
      'statusColor': Colors.red,
      'items': 2,
    },
    {
      'id': 'INV-004',
      'customer': 'برج اللؤلؤ',
      'date': '١٢ فبراير ٢٠٢٤',
      'amount': 16200,
      'status': 'مدفوع',
      'statusColor': Colors.green,
      'items': 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.initialBranch;
    _notificationCount = widget.initialNotificationCount;
  }

  void _onBranchTap() {}
  void _onNotificationsTap() {}

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index != 0) {
      Navigator.pop(context);
    }
  }

  void _onFilterTap() {
    if (!_isBottomSheetOpen) {
      _showFilterBottomSheet(context);
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onNewInvoicePressed() {
    print('Create new invoice');
  }

  // ✅ دالة إضافة عميل جديد (للكونتينر الأخضر)
  void _onAddCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCustomerScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          initialNotificationCount: _notificationCount,
        ),
      ),
    );
  }

  // ✅ دالة الضغط على كونتينر العملاء (للذهاب لشاشة إدارة العملاء)
  void _onCustomersTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomersManagementScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          initialNotificationCount: _notificationCount,
        ),
      ),
    );
  }

  void _onInvoicesTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoicesManagementScreen(
          isEnglish: widget.isEnglish,
          initialBranch: _selectedBranch,
          initialNotificationCount: _notificationCount,
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    _isBottomSheetOpen = true;

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
      builder: (context) {
        return Directionality(
          textDirection: widget.isEnglish
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: FilterBottomSheet(
            isEnglish: widget.isEnglish,
            initialSelectedFilter: _selectedFilter,
            onApplyFilter: (selected) {
              setState(() {
                _selectedFilter = selected;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    ).whenComplete(() {
      _isBottomSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // إذا كان showAppBar = false، نستخدم Scaffold مع AppBar
    if (!widget.showAppBar) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                widget.isEnglish
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios,
                color: Colors.black,
                size: 22,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            widget.isEnglish ? 'Sales' : 'المبيعات',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: _buildContent(),
      );
    }

    // لو showAppBar = true، نستخدم MainLayout
    return MainLayout(
      showAppBar: widget.showAppBar,
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
    return Directionality(
      textDirection: widget.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SalesHeader(
                isEnglish: widget.isEnglish,
                onNewInvoicePressed: _onNewInvoicePressed,
              ),
              const SizedBox(height: 20),

              // ✅ QuickStatsRow مع إضافة onCustomersTap
              QuickStatsRow(
                isEnglish: widget.isEnglish,
                invoicesCount: 156,
                customersCount: 48,
                onAddCustomer: _onAddCustomer,
                onInvoicesTap: _onInvoicesTap,
                onCustomersTap: _onCustomersTap,
              ),
              const SizedBox(height: 20),

              SalesSearchBar(
                isEnglish: widget.isEnglish,
                onFilterTap: _onFilterTap,
                onSearchChanged: _onSearchChanged,
              ),
              const SizedBox(height: 20),

              InvoicesSection(
                isEnglish: widget.isEnglish,
                invoices: invoices,
                onViewAll: _onInvoicesTap,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
