import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/invoices_management.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/sales_search_bar.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/filter_bottom_sheet.dart';
import 'package:saudiaaaa/screens/sales/views/widgets/invoice_filter_chips.dart';
import 'package:saudiaaaa/screens/invoice/views/add_invoice_screen.dart';

class InvoicesManagementScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;
  final int initialFilterIndex; // ✅ إضافة parameter للفلتر المبدئي

  const InvoicesManagementScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
    this.initialFilterIndex = 0, // القيمة الافتراضية: الكل
  });

  @override
  State<InvoicesManagementScreen> createState() =>
      _InvoicesManagementScreenState();
}

class _InvoicesManagementScreenState extends State<InvoicesManagementScreen> {
  late String _selectedBranch;
  int _notificationCount = 0;
  int _currentIndex = 0;
  late int _selectedFilter; // الفلتر المختار
  String _searchQuery = '';
  bool _isBottomSheetOpen = false;

  // جميع الفواتير التجريبية
  final List<Map<String, dynamic>> allInvoices = [
    {
      'id': 'INV-001',
      'customer': 'مؤسسة النخبة',
      'date': '١٥ فبراير ٢٠٢٤',
      'amount': 8500,
      'status': 'مدفوع',
      'statusColor': Colors.green,
      'statusEnum': 'paid',
      'items': 3,
    },
    {
      'id': 'INV-002',
      'customer': 'شركة الواحة',
      'date': '١٤ فبراير ٢٠٢٤',
      'amount': 12500,
      'status': 'معلق',
      'statusColor': Colors.orange,
      'statusEnum': 'pending',
      'items': 5,
    },
    {
      'id': 'INV-003',
      'customer': 'مؤسسة الرمال الذهبية',
      'date': '١٣ فبراير ٢٠٢٤',
      'amount': 9500,
      'status': 'متأخرة',
      'statusColor': Colors.red,
      'statusEnum': 'overdue',
      'items': 2,
    },
    {
      'id': 'INV-004',
      'customer': 'برج اللؤلؤ',
      'date': '١٢ فبراير ٢٠٢٤',
      'amount': 16200,
      'status': 'مدفوع',
      'statusColor': Colors.green,
      'statusEnum': 'paid',
      'items': 4,
    },
    {
      'id': 'INV-005',
      'customer': 'شركة الخليج',
      'date': '١١ فبراير ٢٠٢٤',
      'amount': 22300,
      'status': 'مدفوع',
      'statusColor': Colors.green,
      'statusEnum': 'paid',
      'items': 6,
    },
    {
      'id': 'INV-006',
      'customer': 'مؤسسة الجزيرة',
      'date': '١٠ فبراير ٢٠٢٤',
      'amount': 5400,
      'status': 'معلق',
      'statusColor': Colors.orange,
      'statusEnum': 'pending',
      'items': 2,
    },
    {
      'id': 'INV-007',
      'customer': 'شركة المسيرة',
      'date': '٩ فبراير ٢٠٢٤',
      'amount': 18700,
      'status': 'مسودة',
      'statusColor': Colors.grey,
      'statusEnum': 'draft',
      'items': 3,
    },
  ];

  // الفلاتر مع الأرقام
  late List<Map<String, dynamic>> filters;

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.initialBranch;
    _notificationCount = widget.initialNotificationCount;
    _selectedFilter = widget.initialFilterIndex; // ✅ استخدام الفلتر المبدئي

    // حساب أرقام الفلاتر
    _calculateFilterCounts();
  }

  void _calculateFilterCounts() {
    filters = [
      {
        'label': 'الكل',
        'count': allInvoices.length,
        'color': Colors.grey.shade300,
      },
      {
        'label': 'مسودة',
        'count': allInvoices
            .where((inv) => inv['statusEnum'] == 'draft')
            .length,
        'color': Colors.grey.shade300,
      },
      {
        'label': 'متأخرة',
        'count': allInvoices
            .where((inv) => inv['statusEnum'] == 'overdue')
            .length,
        'color': Colors.red.shade900,
      },
      {
        'label': 'معلق',
        'count': allInvoices
            .where((inv) => inv['statusEnum'] == 'pending')
            .length,
        'color': Colors.red.shade300,
      },
      {
        'label': 'مدفوع',
        'count': allInvoices.where((inv) => inv['statusEnum'] == 'paid').length,
        'color': Colors.green,
      },
    ];
  }

  // فلترة الفواتير حسب الاختيار
  List<Map<String, dynamic>> get filteredInvoices {
    switch (_selectedFilter) {
      case 1: // مسودة
        return allInvoices
            .where((inv) => inv['statusEnum'] == 'draft')
            .toList();
      case 2: // متأخرة
        return allInvoices
            .where((inv) => inv['statusEnum'] == 'overdue')
            .toList();
      case 3: // معلق
        return allInvoices
            .where((inv) => inv['statusEnum'] == 'pending')
            .toList();
      case 4: // مدفوع
        return allInvoices.where((inv) => inv['statusEnum'] == 'paid').toList();
      case 0: // الكل
      default:
        return allInvoices;
    }
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInvoiceScreen(isEnglish: widget.isEnglish),
      ),
    );
  }

  void _onViewAllInvoices() {
    print('View all invoices - already in management screen');
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilter = index;
    });
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
    return MainLayout(
      showAppBar: true,
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
    final filteredInvoicesList = filteredInvoices;

    return Directionality(
      textDirection: widget.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // الهيدر بتاع إدارة الفواتير
              InvoicesManagementHeader(
                isEnglish: widget.isEnglish,
                onNewInvoicePressed: _onNewInvoicePressed,
              ),
              const SizedBox(height: 20),

              // الفلاتر الخمسة
              InvoiceFilterChips(
                isEnglish: widget.isEnglish,
                selectedFilter: _selectedFilter,
                onFilterSelected: _onFilterSelected,
              ),
              const SizedBox(height: 20),

              // شريط البحث
              SalesSearchBar(
                isEnglish: widget.isEnglish,
                onFilterTap: _onFilterTap,
                onSearchChanged: _onSearchChanged,
              ),
              const SizedBox(height: 20),

              // عنوان الفواتير مع العدد
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isEnglish ? 'All Invoices' : 'جميع الفواتير',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${filteredInvoicesList.length} ${widget.isEnglish ? 'invoices' : 'فاتورة'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // قائمة الفواتير المفلترة
              filteredInvoicesList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.isEnglish
                                  ? 'No invoices found'
                                  : 'لا توجد فواتير',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredInvoicesList.length,
                      itemBuilder: (context, index) {
                        return InvoiceCard(
                          invoice: filteredInvoicesList[index],
                        );
                      },
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الصف العلوي: رقم الفاتورة والحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice['id'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: invoice['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: invoice['statusColor'], width: 1),
                  ),
                  child: Text(
                    invoice['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: invoice['statusColor'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // الصف الأوسط: العميل
            Row(
              children: [
                Icon(Icons.person_outline, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    invoice['customer'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // الصف السفلي: التاريخ وعدد المنتجات والمبلغ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // التاريخ
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      invoice['date'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                // عدد المنتجات والمبلغ
                Row(
                  children: [
                    // عدد المنتجات
                    Row(
                      children: [
                        Icon(
                          Icons.inventory,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${invoice['items']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // المبلغ
                    Text(
                      '${invoice['amount']} ر.س',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
