// ==================== import_export_screen.dart ====================
import 'package:flutter/material.dart';

import 'package:saudiaaaa/screens/more/views/export_accounts_screen.dart';
import 'package:saudiaaaa/screens/more/views/export_backup_screen.dart';
import 'package:saudiaaaa/screens/more/views/export_invoices_screen.dart';
import 'package:saudiaaaa/screens/more/views/export_products_screen.dart';
import 'package:saudiaaaa/screens/more/views/export_reports_screen.dart';
import 'package:saudiaaaa/screens/more/views/widgets/export_card.dart';
import 'package:saudiaaaa/screens/more/views/widgets/export_customers_screen.dart';
import 'package:saudiaaaa/screens/more/views/widgets/history_card.dart';
import 'package:saudiaaaa/screens/more/views/widgets/import_card.dart';
import 'package:saudiaaaa/screens/more/views/widgets/stats_cards.dart';
import 'package:saudiaaaa/screens/more/views/widgets/tab_bar_widget.dart';

class ImportExportScreen extends StatefulWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const ImportExportScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  State<ImportExportScreen> createState() => _ImportExportScreenState();
}

class _ImportExportScreenState extends State<ImportExportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // ========== الجزء العلوي البرتقالي ==========
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade800, Colors.orange.shade600],
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
                // صف الأيقونات والعنوان
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // سهم الرجوع
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        widget.isEnglish
                            ? Icons.arrow_back
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    // العنوان
                    Text(
                      widget.isEnglish
                          ? 'Export & Import'
                          : 'التصدير والاستيراد',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // أيقونة الإعدادات
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ===== كروت الإحصائيات =====
                StatsCards(isEnglish: widget.isEnglish),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ===== شريط التبويبات =====
          TabBarWidget(
            isEnglish: widget.isEnglish,
            tabController: _tabController,
            selectedTabIndex: _selectedTabIndex,
          ),

          const SizedBox(height: 16),

          // ===== المحتوى حسب التبويب المحدد =====
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                // تبويب التصدير (index 0)
                _buildExportTab(),

                // تبويب الاستيراد (index 1)
                _buildImportTab(),

                // تبويب السجل (index 2)
                _buildHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== محتوى تبويب التصدير =====
  Widget _buildExportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // العنوان وعدد الخيارات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر عدد الخيارات
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  widget.isEnglish ? '6 Options' : '6 خيارات',
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // العنوان
              Text(
                widget.isEnglish ? 'Export Data' : 'تصدير البيانات',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // كرت الفواتير
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.receipt,
            iconColor: Colors.orange,
            title: widget.isEnglish ? 'Invoices' : 'الفواتير',
            subtitle: widget.isEnglish ? '247 Invoices' : '247 فاتورة',
            formats: ['Excel', 'PDF'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportInvoicesScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // كرت العملاء
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.people,
            iconColor: Colors.green,
            title: widget.isEnglish ? 'Customers' : 'العملاء',
            subtitle: widget.isEnglish ? '89 Customers' : '89 عميل',
            formats: ['Excel', 'CSV'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportCustomersScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // كرت المنتجات
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.inventory,
            iconColor: Colors.blue,
            title: widget.isEnglish ? 'Products' : 'المنتجات',
            subtitle: widget.isEnglish ? '156 Products' : '156 منتج',
            formats: ['Excel', 'CSV'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportProductsScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // كرت الحسابات
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.book,
            iconColor: Colors.purple,
            title: widget.isEnglish ? 'Accounts' : 'الحسابات',
            subtitle: widget.isEnglish ? '47 Accounts' : '47 حساب',
            formats: ['Excel', 'PDF'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportAccountsScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // كرت التقارير المالية
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.bar_chart,
            iconColor: Colors.teal,
            title: widget.isEnglish ? 'Financial Reports' : 'التقارير المالية',
            subtitle: widget.isEnglish
                ? 'Comprehensive Reports'
                : 'تقارير شاملة',
            formats: ['Excel', 'PDF'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportReportsScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // كرت النسخة الاحتياطية
          ExportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.storage,
            iconColor: Colors.red,
            title: widget.isEnglish ? 'Full Backup' : 'نسخة احتياطية كاملة',
            subtitle: widget.isEnglish ? 'All Data' : 'جميع البيانات',
            formats: ['JSON', 'SQL'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExportBackupScreen(
                    isEnglish: widget.isEnglish,
                    selectedBranch: widget.selectedBranch,
                    notificationCount: widget.notificationCount,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ===== محتوى تبويب الاستيراد =====
  Widget _buildImportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // العنوان وعدد الخيارات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر عدد الخيارات
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  widget.isEnglish ? '4 Options' : '4 خيارات',
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // العنوان
              Text(
                widget.isEnglish ? 'Import Data' : 'استيراد البيانات',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // رسالة التنبيه
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.amber.shade800,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isEnglish ? 'Important Alert!' : 'تنبيه مهم !',
                        style: TextStyle(
                          color: Colors.amber.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.isEnglish
                            ? 'Make sure data is correct before importing. Duplicate data will be updated automatically.'
                            : 'تأكد من صحة البيانات قبل الاستيراد. البيانات المكررة سيتم تحديثها تلقائياً.',
                        style: TextStyle(
                          color: Colors.amber.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // كرت استيراد العملاء
          ImportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.people,
            iconColor: Colors.green,
            title: widget.isEnglish ? 'Customers' : 'العملاء',
            subtitle: widget.isEnglish
                ? 'Import from Excel/CSV'
                : 'استيراد من Excel/CSV',
            formats: ['Excel', 'CSV'],
            onTap: () {
              // Navigator.push للشاشة الخاصة باستيراد العملاء
            },
          ),

          const SizedBox(height: 12),

          // كرت استيراد المنتجات
          ImportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.inventory,
            iconColor: Colors.blue,
            title: widget.isEnglish ? 'Products' : 'المنتجات',
            subtitle: widget.isEnglish
                ? 'Import from Excel/CSV'
                : 'استيراد من Excel/CSV',
            formats: ['Excel', 'CSV'],
            onTap: () {
              // Navigator.push للشاشة الخاصة باستيراد المنتجات
            },
          ),

          const SizedBox(height: 12),

          // كرت استيراد الفواتير
          ImportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.receipt,
            iconColor: Colors.orange,
            title: widget.isEnglish ? 'Invoices' : 'الفواتير',
            subtitle: widget.isEnglish
                ? 'Import from Excel/PDF'
                : 'استيراد من Excel/PDF',
            formats: ['Excel', 'PDF'],
            onTap: () {
              // Navigator.push للشاشة الخاصة باستيراد الفواتير
            },
          ),

          const SizedBox(height: 12),

          // كرت استيراد الحسابات
          ImportCard(
            isEnglish: widget.isEnglish,
            icon: Icons.book,
            iconColor: Colors.purple,
            title: widget.isEnglish ? 'Accounts' : 'الحسابات',
            subtitle: widget.isEnglish
                ? 'Import from Excel/CSV'
                : 'استيراد من Excel/CSV',
            formats: ['Excel', 'CSV'],
            onTap: () {
              // Navigator.push للشاشة الخاصة باستيراد الحسابات
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ===== محتوى تبويب السجل =====
  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // عنوان السجل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // عدد العمليات
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Text(
                  widget.isEnglish ? '3 Operations' : '3 عملية',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // العنوان
              Text(
                widget.isEnglish ? 'Operations History' : 'سجل العمليات',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // كرت سجل الفواتير
          HistoryCard(
            isEnglish: widget.isEnglish,
            icon: Icons.receipt,
            iconColor: Colors.orange,
            title: widget.isEnglish ? 'Invoices' : 'الفواتير',
            date: widget.isEnglish
                ? 'Feb 14, 2026, 10:30 AM'
                : '١٤ فبراير ٢٠٢٦، ١٠:٣٠ ص',
            records: '247',
            fileSize: '2.4 MB',
            format: 'Excel',
          ),

          const SizedBox(height: 12),

          // كرت سجل العملاء
          HistoryCard(
            isEnglish: widget.isEnglish,
            icon: Icons.people,
            iconColor: Colors.green,
            title: widget.isEnglish ? 'Customers' : 'العملاء',
            date: widget.isEnglish
                ? 'Feb 13, 2026, 02:20 PM'
                : '١٣ فبراير ٢٠٢٦، ٠٢:٢٠ م',
            records: '89',
            fileSize: '156 KB',
            format: 'CSV',
          ),

          const SizedBox(height: 12),

          // كرت سجل المنتجات
          HistoryCard(
            isEnglish: widget.isEnglish,
            icon: Icons.inventory,
            iconColor: Colors.blue,
            title: widget.isEnglish ? 'Products' : 'المنتجات',
            date: widget.isEnglish
                ? 'Feb 12, 2026, 09:15 AM'
                : '١٢ فبراير ٢٠٢٦، ٠٩:١٥ ص',
            records: '156',
            fileSize: '1.8 MB',
            format: 'Excel',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
