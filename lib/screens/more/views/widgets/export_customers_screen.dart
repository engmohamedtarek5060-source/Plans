// ==================== export_customers_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/widgets/preview_card.dart'; // 👈 تم تغيير المسار

class ExportCustomersScreen extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const ExportCustomersScreen({
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
          // ========== الجزء العلوي البرتقالي ==========
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                16,
                50,
                16,
                30,
              ), // 👈 تم تعديل padding
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
                        isEnglish ? 'Export Customers' : 'تصدير العملاء',
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
                      color: Colors.orange.shade400.withOpacity(0.3),
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
                                    ? 'Export customer list with complete data'
                                    : 'تصدير قائمة العملاء مع البيانات الكاملة',
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
                                    isEnglish ? '89 Records' : '89 سجل',
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
                                    '156 KB',
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
                            Icons.people,
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
                // قسم صيغة الملف
                _buildSection(
                  title: isEnglish ? 'File Format' : 'صيغة الملف',
                  child: _buildFormatSelector(context),
                ),

                const SizedBox(height: 20),

                // قسم الفترة الزمنية
                _buildSection(
                  title: isEnglish ? 'Time Period' : 'الفترة الزمنية',
                  child: _buildPeriodSelector(context),
                ),

                const SizedBox(height: 20),

                // قسم خيارات التصدير
                _buildSection(
                  title: isEnglish ? 'Export Options' : 'خيارات التصدير',
                  child: _buildAdvancedOptions(context),
                ),

                const SizedBox(height: 20),

                // قسم معاينة التصدير 👈 تم تعديل هذه
                PreviewCard(
                  isEnglish: isEnglish,
                  records: '89',
                  fileSize: '156 KB',
                  format: 'Excel',
                  period: isEnglish ? 'This Month' : 'هذا الشهر',
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
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Start Export' : 'بدء التصدير',
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

  Widget _buildFormatSelector(BuildContext context) {
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
            _showFormatDialog(context); // 👈 إضافة الـ onTap
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.insert_drive_file,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Excel',
                        style: TextStyle(
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
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Text(
                    'excel',
                    style: TextStyle(
                      color: Colors.amber.shade800,
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

  // 👈 إضافة دالة اختيار الصيغة
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
            _showPeriodDialog(context); // 👈 إضافة الـ onTap
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
                        'هذا الشهر',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish
                            ? 'Tap to change period'
                            : 'انقر لتغيير الفترة',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.filter_list, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 👈 إضافة دالة اختيار الفترة
  void _showPeriodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                title: Text(isEnglish ? 'Last Month' : 'الشهر الماضي'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                title: Text(isEnglish ? 'This Quarter' : 'هذا الربع'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                title: Text(isEnglish ? 'This Year' : 'هذه السنة'),
                onTap: () => Navigator.pop(dialogContext),
              ),
              ListTile(
                title: Text(isEnglish ? 'Custom Range' : 'نطاق مخصص'),
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

  Widget _buildAdvancedOptions(BuildContext context) {
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
            _showAdvancedOptionsDialog(context); // 👈 إضافة الـ onTap
          },
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

  // 👈 إضافة دالة الخيارات المتقدمة
  void _showAdvancedOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Advanced Options' : 'خيارات متقدمة',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: Text(
                  isEnglish
                      ? 'Include Inactive Customers'
                      : 'تضمين العملاء غير النشطين',
                ),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text(
                  isEnglish
                      ? 'Include Customer Notes'
                      : 'تضمين ملاحظات العملاء',
                ),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text(
                  isEnglish
                      ? 'Include Transaction History'
                      : 'تضمين سجل المعاملات',
                ),
                value: false,
                onChanged: (value) {},
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
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                isEnglish ? 'Apply' : 'تطبيق',
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }
}
