// ==================== settings_section.dart ====================
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final bool isEnglish;
  final Function(String) onLanguageSelected; // تغيير هنا

  const SettingsSection({
    super.key,
    required this.isEnglish,
    required this.onLanguageSelected, // تغيير هنا
  });

  String _getCurrentLanguage() {
    return isEnglish ? 'English' : 'العربية';
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Select Language' : 'اختر اللغة',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // العربية
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: isEnglish ? Colors.grey : Colors.orange,
                ),
                title: Text(
                  'العربية',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isEnglish ? FontWeight.normal : FontWeight.bold,
                    color: isEnglish ? Colors.black : Colors.orange,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onLanguageSelected('ar'); // اختيار العربية
                },
              ),
              // English
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: !isEnglish ? Colors.grey : Colors.orange,
                ),
                title: Text(
                  'English',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: !isEnglish
                        ? FontWeight.normal
                        : FontWeight.bold,
                    color: !isEnglish ? Colors.black : Colors.orange,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onLanguageSelected('en'); // اختيار الإنجليزية
                },
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان "الإعدادات"
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 4),
          child: Text(
            isEnglish ? 'Settings' : 'الإعدادات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),

        // كونتينر الإعدادات
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // عنصر تبديل الشركة
              _buildSettingsItem(
                icon: Icons.business,
                label: isEnglish ? 'Switch Company' : 'تبديل الشركة',
                value: isEnglish
                    ? 'Al Nokhba Trading Co.'
                    : 'شركة النخبة للتجارة',
                showDivider: true,
                showArrow: true,
                onTap: () {
                  // وظيفة تبديل الشركة
                  print('Switch company tapped');
                },
              ),

              // عنصر اللغة (مع سهم)
              _buildSettingsItem(
                icon: Icons.language,
                label: isEnglish ? 'Language' : 'اللغة',
                value: _getCurrentLanguage(),
                showDivider: false,
                showArrow: true,
                onTap: () =>
                    _showLanguageDialog(context), // فتح نافذة اختيار اللغة
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String label,
    required String value,
    required bool showDivider,
    required bool showArrow,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // السهم على اليسار (في العربية) / على اليمين (في الإنجليزية)
                if (showArrow) ...[
                  Icon(
                    isEnglish ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],

                // المسافة المرنة
                const Spacer(),

                // النصوص في اليمين
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      if (value.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // الأيقونة الرئيسية (رمادية)
                Icon(icon, color: Colors.grey[600], size: 24),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: Colors.grey.shade200,
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
