// ==================== export_accounts_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/widgets/preview_card.dart';

class ExportAccountsScreen extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const ExportAccountsScreen({
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
                  colors: [Colors.purple.shade800, Colors.purple.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
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
                        isEnglish ? 'Export Accounts' : 'تصدير الحسابات',
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
                      color: Colors.purple.shade400.withOpacity(0.3),
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
                                    ? 'Export chart of accounts with balances'
                                    : 'تصدير دليل الحسابات مع الأرصدة',
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
                                    isEnglish ? '47 Accounts' : '٤٧ حساب',
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
                                    '890 KB',
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
                            Icons.book,
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
                // قسم نوع الحسابات
                _buildSection(
                  title: isEnglish ? 'Account Type' : 'نوع الحسابات',
                  child: _buildAccountTypeSelector(),
                ),

                const SizedBox(height: 20),

                // قسم صيغة الملف
                _buildSection(
                  title: isEnglish ? 'File Format' : 'صيغة الملف',
                  child: _buildFormatSelector(context, 'Excel'),
                ),

                const SizedBox(height: 20),

                // قسم الفترة الزمنية
                _buildSection(
                  title: isEnglish ? 'As of Date' : 'حتى تاريخ',
                  child: _buildDateSelector(context),
                ),

                const SizedBox(height: 20),

                // قسم الحسابات المحددة
                _buildSection(
                  title: isEnglish ? 'Select Accounts' : 'اختر الحسابات',
                  child: _buildAccountsList(),
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
                  records: '47 Accounts',
                  fileSize: '890 KB',
                  format: 'Excel',
                  period: isEnglish ? 'End of Month' : 'نهاية الشهر',
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
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Export Accounts' : 'تصدير الحسابات',
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

  Widget _buildAccountTypeSelector() {
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'جميع الحسابات',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish ? 'All account types' : 'جميع أنواع الحسابات',
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

  void _showAccountTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Select Account Type' : 'اختر نوع الحسابات',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.purple,
                  ),
                ),
                title: Text(isEnglish ? 'All Accounts' : 'جميع الحسابات'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                  ),
                ),
                title: Text(isEnglish ? 'Assets' : 'الأصول'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_down, color: Colors.red),
                ),
                title: Text(isEnglish ? 'Liabilities' : 'الخصوم'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.blue),
                ),
                title: Text(isEnglish ? 'Equity' : 'حقوق الملكية'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_up, color: Colors.orange),
                ),
                title: Text(isEnglish ? 'Revenues' : 'الإيرادات'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_down, color: Colors.red),
                ),
                title: Text(isEnglish ? 'Expenses' : 'المصروفات'),
                onTap: () => Navigator.pop(dialogContext),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
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

  Widget _buildFormatSelector(BuildContext context, String defaultFormat) {
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
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.insert_drive_file,
                    color: Colors.purple,
                  ),
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
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Text(
                    defaultFormat.toLowerCase(),
                    style: TextStyle(
                      color: Colors.purple.shade800,
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
      builder: (BuildContext dialogContext) {
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
                onTap: () => Navigator.pop(dialogContext),
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
                onTap: () => Navigator.pop(dialogContext),
              ),
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
                onTap: () => Navigator.pop(dialogContext),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
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

  Widget _buildDateSelector(BuildContext context) {
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
            _showDateDialog(context);
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
                        '٣١ ديسمبر ٢٠٢٥',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish
                            ? 'End of fiscal year'
                            : 'نهاية السنة المالية',
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

  void _showDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
  }

  Widget _buildAccountsList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildAccountCheckTile(
            code: '1000',
            title: isEnglish ? 'Assets' : 'الأصول',
            balance: '850,000',
            value: true,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildAccountCheckTile(
            code: '2000',
            title: isEnglish ? 'Liabilities' : 'الخصوم',
            balance: '350,000',
            value: true,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildAccountCheckTile(
            code: '3000',
            title: isEnglish ? 'Equity' : 'حقوق الملكية',
            balance: '500,000',
            value: true,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildAccountCheckTile(
            code: '4000',
            title: isEnglish ? 'Revenues' : 'الإيرادات',
            balance: '280,000',
            value: false,
          ),
          const Divider(height: 1, indent: 70, endIndent: 16),
          _buildAccountCheckTile(
            code: '5000',
            title: isEnglish ? 'Expenses' : 'المصروفات',
            balance: '180,000',
            value: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCheckTile({
    required String code,
    required String title,
    required String balance,
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
            child: Center(
              child: Text(
                code.substring(0, 1),
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  '$balance ${isEnglish ? 'SAR' : 'ر.س'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Checkbox(
            value: value,
            onChanged: (newValue) {},
            activeColor: Colors.purple,
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
