import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';

class CustomersManagementScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const CustomersManagementScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  State<CustomersManagementScreen> createState() =>
      _CustomersManagementScreenState();
}

class _CustomersManagementScreenState extends State<CustomersManagementScreen> {
  late String _selectedBranch;
  int _notificationCount = 0;
  int _currentIndex = 0;
  int _selectedFilter = 0; // 0: الكل, 1: نشط, 2: غير نشط, 3: محظور
  String _searchQuery = '';

  // جميع العملاء التجريبية
  final List<Map<String, dynamic>> allCustomers = [
    {
      'name': 'مؤسسة النخبة للتجارة',
      'nameEn': 'Al Nokhba Trading Establishment',
      'phone': '٠٥٦٧٨٩١٢٣٤',
      'email': 'info@elnokhba.com',
      'totalInvoices': 15,
      'totalAmount': 45000,
      'status': 'نشط',
      'statusEn': 'Active',
      'statusEnum': 'active',
      'statusColor': Colors.green,
    },
    {
      'name': 'شركة الواحة المحدودة',
      'nameEn': 'Al Waha Company Limited',
      'phone': '٠٥٠١٢٣٤٥٦٧',
      'email': 'contact@alwaha.com',
      'totalInvoices': 8,
      'totalAmount': 23500,
      'status': 'نشط',
      'statusEn': 'Active',
      'statusEnum': 'active',
      'statusColor': Colors.green,
    },
    {
      'name': 'مؤسسة الرمال الذهبية',
      'nameEn': 'Golden Sands Establishment',
      'phone': '٠٥٥٤٤٣٣٢٢١',
      'email': 'info@goldensands.com',
      'totalInvoices': 3,
      'totalAmount': 9500,
      'status': 'غير نشط',
      'statusEn': 'Inactive',
      'statusEnum': 'inactive',
      'statusColor': Colors.red.shade300,
    },
    {
      'name': 'شركة الخليج للتجارة',
      'nameEn': 'Al Khaleej Trading Company',
      'phone': '٠٥٠٩٩٨٧٧٦٥',
      'email': 'info@alkhaleej.com',
      'totalInvoices': 22,
      'totalAmount': 67800,
      'status': 'نشط',
      'statusEn': 'Active',
      'statusEnum': 'active',
      'statusColor': Colors.green,
    },
    {
      'name': 'مؤسسة الجزيرة',
      'nameEn': 'Al Jazeera Establishment',
      'phone': '٠٥٦٥٥٤٤٣٣٢',
      'email': 'contact@aljazeera.com',
      'totalInvoices': 0,
      'totalAmount': 0,
      'status': 'محظور',
      'statusEn': 'Blocked',
      'statusEnum': 'blocked',
      'statusColor': Colors.red.shade900,
    },
    {
      'name': 'شركة المسيرة',
      'nameEn': 'Al Maseera Company',
      'phone': '٠٥٥٣٣٢٢١١٩',
      'email': 'info@almaseera.com',
      'totalInvoices': 5,
      'totalAmount': 18700,
      'status': 'غير نشط',
      'statusEn': 'Inactive',
      'statusEnum': 'inactive',
      'statusColor': Colors.red.shade300,
    },
  ];

  // دالة لحساب أعداد الفلاتر
  Map<String, int> get filterCounts {
    return {
      'all': allCustomers.length,
      'active': allCustomers.where((c) => c['statusEnum'] == 'active').length,
      'inactive': allCustomers
          .where((c) => c['statusEnum'] == 'inactive')
          .length,
      'blocked': allCustomers.where((c) => c['statusEnum'] == 'blocked').length,
    };
  }

  // دالة فلترة العملاء حسب الفلتر المختار وحسب البحث
  List<Map<String, dynamic>> get filteredCustomers {
    // أولاً: الفلترة حسب الحالة
    List<Map<String, dynamic>> statusFiltered;

    switch (_selectedFilter) {
      case 1: // نشط
        statusFiltered = allCustomers
            .where((c) => c['statusEnum'] == 'active')
            .toList();
        break;
      case 2: // غير نشط
        statusFiltered = allCustomers
            .where((c) => c['statusEnum'] == 'inactive')
            .toList();
        break;
      case 3: // محظور
        statusFiltered = allCustomers
            .where((c) => c['statusEnum'] == 'blocked')
            .toList();
        break;
      case 0: // الكل
      default:
        statusFiltered = allCustomers;
    }

    // ثانياً: الفلترة حسب البحث
    if (_searchQuery.isEmpty) {
      return statusFiltered;
    }

    return statusFiltered.where((customer) {
      final name = (widget.isEnglish ? customer['nameEn'] : customer['name'])
          .toLowerCase();
      final phone = customer['phone'].toString();
      final email = customer['email'].toLowerCase();
      final query = _searchQuery.toLowerCase();

      return name.contains(query) ||
          phone.contains(query) ||
          email.contains(query);
    }).toList();
  }

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

  void _onAddCustomer() {
    print(widget.isEnglish ? 'Add new customer' : 'إضافة عميل جديد');
    // هنا هتضيف شاشة إضافة عميل جديدة
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
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
    final counts = filterCounts;
    final filteredList = filteredCustomers;

    return Directionality(
      textDirection: widget.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // الهيدر بتاع العملاء
              _buildHeader(),
              const SizedBox(height: 20),

              // الكارتين جنب بعض
              Row(
                children: [
                  Expanded(child: _buildTotalCustomersCard(counts['all']!)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildOutstandingBalanceCard()),
                ],
              ),
              const SizedBox(height: 20),

              // فلاتر العملاء (الـ 4 كونتينرات) مع الأعداد الحقيقية
              _buildCustomerFilters(counts),
              const SizedBox(height: 20),

              // شريط البحث
              _buildSearchBar(),
              const SizedBox(height: 20),

              // عنوان القائمة مع عدد النتائج
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isEnglish ? 'Customer List' : 'قائمة العملاء',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.isEnglish
                        ? '${filteredList.length} ${filteredList.length == 1 ? 'customer' : 'customers'}'
                        : '${filteredList.length} ${filteredList.length == 1 ? 'عميل' : 'عملاء'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // قائمة العملاء المفلترة
              filteredList.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return _buildCustomerCard(filteredList[index]);
                      },
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // العنوان
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isEnglish ? 'Customers' : 'العملاء',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              widget.isEnglish
                  ? 'Customers Database Management'
                  : 'إدارة قاعدة بيانات العملاء',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        // زر إضافة عميل
        ElevatedButton.icon(
          onPressed: _onAddCustomer,
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            widget.isEnglish ? 'Add Customer' : 'إضافة عميل',
            style: const TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCustomersCard(int totalCount) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF9E6), // أصفر فاتح
            Color(0xFFFFFFFF), // أبيض
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: الدائرة البرتقالية والسهم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              Icon(Icons.trending_up, color: Colors.orange, size: 20),
            ],
          ),
          const SizedBox(height: 16),

          // الرقم
          Text(
            totalCount.toString(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // النص
          Text(
            widget.isEnglish ? 'Total Customers' : 'إجمالي العملاء',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildOutstandingBalanceCard() {
    // حساب إجمالي الرصيد المستحق من العملاء النشطين فقط
    double totalOutstanding = allCustomers.fold(0, (sum, customer) {
      if (customer['statusEnum'] == 'active') {
        return sum + (customer['totalAmount'] as int);
      }
      return sum;
    });

    // تنسيق الرقم حسب اللغة
    String formattedAmount;
    if (widget.isEnglish) {
      formattedAmount = '${totalOutstanding.toStringAsFixed(0)} SAR';
    } else {
      formattedAmount = '${totalOutstanding.toStringAsFixed(0)} ر.س';
    }

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8F5E9), // أخضر فاتح
            Color(0xFFFFFFFF), // أبيض
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: الدائرة الخضراء
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 16),

          // الرقم
          Text(
            formattedAmount,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),

          // النص
          Text(
            widget.isEnglish ? 'Outstanding Balance' : 'رصيد مستحق',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerFilters(Map<String, int> counts) {
    final filters = [
      {
        'label': widget.isEnglish ? 'All' : 'الكل',
        'count': counts['all'],
        'color': Colors.orange,
        'textColor': Colors.orange,
      },
      {
        'label': widget.isEnglish ? 'Active' : 'نشط',
        'count': counts['active'],
        'color': Colors.green,
        'textColor': Colors.green,
      },
      {
        'label': widget.isEnglish ? 'Inactive' : 'غير نشط',
        'count': counts['inactive'],
        'color': Colors.red.shade300,
        'textColor': Colors.red.shade300,
      },
      {
        'label': widget.isEnglish ? 'Blocked' : 'محظور',
        'count': counts['blocked'],
        'color': Colors.red.shade900,
        'textColor': Colors.red.shade900,
      },
    ];

    return Row(
      children: List.generate(filters.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index < filters.length - 1 ? 8 : 0,
                right: index > 0 ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedFilter == index
                      ? Colors.orange
                      : Colors.grey.shade300,
                  width: _selectedFilter == index ? 2 : 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    filters[index]['count'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _selectedFilter == index
                          ? Colors.orange
                          : filters[index]['textColor'] as Color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    filters[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: _selectedFilter == index
                          ? Colors.orange
                          : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.isEnglish
                    ? 'Search by name, phone or email...'
                    : 'بحث بالاسم أو التليفون أو الإيميل...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.grey[600], size: 20),
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.grey[600]),
            onPressed: () {
              // هنا هتضيف شاشة فلترة متقدمة لو عايز
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    // اختيار الاسم حسب اللغة
    String displayName = widget.isEnglish
        ? customer['nameEn']
        : customer['name'];
    String displayStatus = widget.isEnglish
        ? customer['statusEn']
        : customer['status'];

    // تنسيق المبلغ حسب اللغة
    String amountText = widget.isEnglish
        ? '${customer['totalAmount']} SAR'
        : '${customer['totalAmount']} ر.س';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
            // الصف العلوي: الاسم والحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: customer['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: customer['statusColor'],
                      width: 1,
                    ),
                  ),
                  child: Text(
                    displayStatus,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: customer['statusColor'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // معلومات الاتصال
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  customer['phone'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.email, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    customer['email'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // إحصائيات سريعة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      widget.isEnglish
                          ? '${customer['totalInvoices']} ${customer['totalInvoices'] == 1 ? 'invoice' : 'invoices'}'
                          : '${customer['totalInvoices']} ${customer['totalInvoices'] == 1 ? 'فاتورة' : 'فواتير'}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  amountText,
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
      ),
    );
  }

  Widget _buildEmptyState() {
    String message;
    if (_searchQuery.isNotEmpty) {
      message = widget.isEnglish
          ? 'No customers match your search'
          : 'لا يوجد عملاء مطابقين للبحث';
    } else {
      message = widget.isEnglish ? 'No customers found' : 'لا يوجد عملاء';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                  });
                },
                child: Text(
                  widget.isEnglish ? 'Clear search' : 'مسح البحث',
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
