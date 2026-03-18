// ==================== export_reports_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/widgets/preview_card.dart';

class ExportReportsScreen extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const ExportReportsScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // ========== الجزء العلوي ==========
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade800, Colors.teal.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // صف الرجوع والعنوان
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          isEnglish ? Icons.arrow_back : Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Text(
                        isEnglish
                            ? 'Export Financial Reports'
                            : 'تصدير التقارير المالية',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // كرت المعلومات الرئيسي
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade400.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEnglish
                                    ? 'Export comprehensive financial reports'
                                    : 'تصدير التقارير المالية الشاملة',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    isEnglish ? '12 Reports' : '١٢ تقرير',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '3.5 MB',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bar_chart,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // ===== المحتوى الرئيسي =====
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // قسم نوع التقرير
                _buildSection(
                  title: isEnglish ? 'Report Type' : 'نوع التقرير',
                  child: _buildReportTypeSelector(),
                ),

                const SizedBox(height: 20),

                // قسم صيغة الملف
                _buildSection(
                  title: isEnglish ? 'File Format' : 'صيغة الملف',
                  child: _buildFormatSelector('PDF', context),
                ),

                const SizedBox(height: 20),

                // قسم الفترة الزمنية
                _buildSection(
                  title: isEnglish ? 'Time Period' : 'الفترة الزمنية',
                  child: _buildPeriodSelector(context),
                ),

                const SizedBox(height: 20),

                // قسم التقارير المحددة
                _buildSection(
                  title: isEnglish ? 'Select Reports' : 'اختر التقارير',
                  child: _buildReportsList(),
                ),

                const SizedBox(height: 20),

                // قسم خيارات التصدير
                _buildSection(
                  title: isEnglish ? 'Export Options' : 'خيارات التصدير',
                  child: _buildExportOptions(),
                ),

                const SizedBox(height: 20),

                // قسم معاينة التصدير
                PreviewCard(
                  isEnglish: isEnglish,
                  records: '12 Reports',
                  fileSize: '3.5 MB',
                  format: 'PDF',
                  period: isEnglish ? 'This Quarter' : 'هذا الربع',
                ),

                const SizedBox(height: 30),

                // زر التصدير
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Export Reports' : 'تصدير التقارير',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildReportTypeSelector() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Note: context needs to be accessed differently in a StatelessWidget
            // Consider refactoring to pass context or use navigatorKey
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pie_chart, color: Colors.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التقارير المالية الشاملة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish
                            ? 'All financial reports'
                            : 'جميع التقارير المالية',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReportTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Select Report Type' : 'اختر نوع التقرير',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pie_chart, color: Colors.teal),
                ),
                title: Text(
                  isEnglish ? 'Comprehensive Reports' : 'تقارير شاملة',
                ),
                subtitle: Text(
                  isEnglish ? 'All financial reports' : 'جميع التقارير المالية',
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_up, color: Colors.blue),
                ),
                title: Text(isEnglish ? 'Income Statement' : 'قائمة الدخل'),
                subtitle: Text(
                  isEnglish ? 'Revenue and expenses' : 'الإيرادات والمصروفات',
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.green),
                ),
                title: Text(isEnglish ? 'Balance Sheet' : 'الميزانية العمومية'),
                subtitle: Text(
                  isEnglish ? 'Assets and liabilities' : 'الأصول والخصوم',
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_down, color: Colors.orange),
                ),
                title: Text(isEnglish ? 'Cash Flow' : 'التدفقات النقدية'),
                subtitle: Text(isEnglish ? 'Cash movements' : 'حركات النقدية'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                isEnglish ? 'Cancel' : 'إلغاء',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormatSelector(String defaultFormat, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showFormatDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        defaultFormat,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish
                            ? 'Tap to change format'
                            : 'انقر لتغيير الصيغة',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Text(
                    defaultFormat.toLowerCase(),
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Select Format' : 'اختر الصيغة',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                ),
                title: const Text('PDF'),
                subtitle: Text(
                  isEnglish ? 'Printable format' : 'صيغة قابلة للطباعة',
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.insert_drive_file,
                    color: Colors.green,
                  ),
                ),
                title: const Text('Excel'),
                subtitle: Text(
                  isEnglish ? 'Spreadsheet format' : 'صيغة جداول بيانات',
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.code, color: Colors.blue),
                ),
                title: const Text('CSV'),
                subtitle: Text(
                  isEnglish ? 'Comma separated values' : 'قيم مفصولة بفواصل',
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                isEnglish ? 'Cancel' : 'إلغاء',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showPeriodDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_today, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'هذا الربع',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish ? 'Current quarter' : 'الربع الحالي',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPeriodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Select Period' : 'اختر الفترة',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(isEnglish ? 'This Month' : 'هذا الشهر'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text(isEnglish ? 'This Quarter' : 'هذا الربع'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text(isEnglish ? 'This Year' : 'هذه السنة'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text(isEnglish ? 'Custom Range' : 'نطاق مخصص'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReportsList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildReportCheckTile(
            title: isEnglish ? 'Income Statement' : 'قائمة الدخل',
            subtitle: isEnglish
                ? 'Revenue and expenses'
                : 'الإيرادات والمصروفات',
            value: true,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildReportCheckTile(
            title: isEnglish ? 'Balance Sheet' : 'الميزانية العمومية',
            subtitle: isEnglish ? 'Assets and liabilities' : 'الأصول والخصوم',
            value: true,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildReportCheckTile(
            title: isEnglish ? 'Cash Flow' : 'التدفقات النقدية',
            subtitle: isEnglish ? 'Cash movements' : 'حركات النقدية',
            value: false,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildReportCheckTile(
            title: isEnglish ? 'Accounts Receivable' : 'الذمم المدينة',
            subtitle: isEnglish ? 'Customer balances' : 'أرصدة العملاء',
            value: false,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildReportCheckTile(
            title: isEnglish ? 'Accounts Payable' : 'الذمم الدائنة',
            subtitle: isEnglish ? 'Supplier balances' : 'أرصدة الموردين',
            value: false,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCheckTile({
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              value ? Icons.check_circle : Icons.radio_button_unchecked,
              color: value ? Colors.teal : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Checkbox(
            value: value,
            onChanged: (newValue) {},
            activeColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.grey),
                SizedBox(width: 12),
                Text(
                  'إعدادات متقدمة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
