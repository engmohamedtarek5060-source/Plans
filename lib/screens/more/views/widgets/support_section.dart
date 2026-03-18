// ==================== support_section.dart (محدث كامل) ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/login/views/login_screen.dart';
import 'package:saudiaaaa/screens/more/views/support_screen.dart';
import 'package:saudiaaaa/screens/more/views/help_center_screen.dart';
import 'package:saudiaaaa/screens/more/views/terms_and_conditions_screen.dart';
import 'package:saudiaaaa/screens/more/views/privacy_policy_screen.dart';

class SupportSection extends StatelessWidget {
  final bool isEnglish;

  const SupportSection({super.key, required this.isEnglish});

  void _navigateToSupportScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupportScreen(isEnglish: isEnglish),
      ),
    );
  }

  void _navigateToHelpCenter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpCenterScreen(isEnglish: isEnglish),
      ),
    );
  }

  void _navigateToTermsAndConditions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TermsAndConditionsScreen(isEnglish: isEnglish),
      ),
    );
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyPolicyScreen(isEnglish: isEnglish),
      ),
    );
  }

  // 👈 إضافة دالة التنقل إلى شاشة تسجيل الدخول
  void _navigateToLoginScreen(BuildContext context) {
    // استخدام pushAndRemoveUntil لإزالة جميع الشاشات السابقة من المكدس
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false, // إزالة جميع الشاشات السابقة
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان "الدعم والمساعدة"
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 4),
          child: Text(
            isEnglish ? 'Support & Help' : 'الدعم والمساعدة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),

        // كونتينر الدعم والمساعدة
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
              // عنصر مركز المساعدة
              _buildSupportItem(
                icon: Icons.help_outline,
                label: isEnglish ? 'Help Center' : 'مركز المساعدة',
                showDivider: true,
                onTap: () => _navigateToHelpCenter(context),
              ),

              // عنصر اتصل بالدعم
              _buildSupportItem(
                icon: Icons.headset_mic_outlined,
                label: isEnglish ? 'Contact Support' : 'اتصل بالدعم',
                showDivider: true,
                onTap: () => _navigateToSupportScreen(context),
              ),

              // عنصر الشروط والأحكام
              _buildSupportItem(
                icon: Icons.description_outlined,
                label: isEnglish ? 'Terms & Conditions' : 'الشروط والأحكام',
                showDivider: true,
                onTap: () => _navigateToTermsAndConditions(context),
              ),

              // عنصر سياسة الخصوصية
              _buildSupportItem(
                icon: Icons.lock_outline,
                label: isEnglish ? 'Privacy Policy' : 'سياسة الخصوصية',
                showDivider: false,
                onTap: () => _navigateToPrivacyPolicy(context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // زر تسجيل الخروج 👈 مع إضافة التنقل
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _navigateToLoginScreen(context), // 👈 تغيير هنا
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      isEnglish ? 'Logout' : 'تسجيل الخروج',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.logout, color: Colors.red, size: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportItem({
    required IconData icon,
    required String label,
    required bool showDivider,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    isEnglish ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  const Spacer(),
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(icon, color: Colors.grey[600], size: 24),
                ],
              ),
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
