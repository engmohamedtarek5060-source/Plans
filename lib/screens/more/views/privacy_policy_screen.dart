// ==================== privacy_policy_screen.dart ====================
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final bool isEnglish;

  const PrivacyPolicyScreen({super.key, required this.isEnglish});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  // مجموعة لتتبع الأقسام المفتوحة
  final Set<int> _expandedSections = {};

  void _toggleSection(int sectionIndex) {
    setState(() {
      if (_expandedSections.contains(sectionIndex)) {
        _expandedSections.remove(sectionIndex);
      } else {
        _expandedSections.add(sectionIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            widget.isEnglish ? Icons.arrow_back : Icons.arrow_forward,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          widget.isEnglish ? 'Privacy Policy' : 'سياسة الخصوصية',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== العنوان الرئيسي وآخر تحديث =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade300, Colors.orange.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEnglish ? 'Privacy Policy' : 'سياسة الخصوصية',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isEnglish
                        ? 'Last Updated: March 2026'
                        : 'آخر تحديث: مارس ٢٠٢٦',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== نحن نحمي خصوصيتك =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEnglish
                        ? 'We Protect Your Privacy'
                        : 'نحن نحمي خصوصيتك',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isEnglish
                        ? 'Your privacy is our trust. We are committed to the highest standards of data protection.'
                        : 'خصوصيتك أمانة لدينا. نلتزم بأعلى معايير حماية البيانات.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== تاريخ السريان =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Text(
                widget.isEnglish
                    ? 'Effective Date: March 1, 2026'
                    : 'سريان المفعول: ١ مارس ٢٠٢٦',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // ===== التزاماتنا تجاهك =====
            Text(
              widget.isEnglish ? 'Our Commitments to You' : 'التزاماتنا تجاهك',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ===== بطاقات الالتزامات =====
            Row(
              children: [
                Expanded(
                  child: _buildCommitmentCard(
                    icon: Icons.delete_forever,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish ? 'Right to Delete' : 'تحقق الحذف',
                    description: widget.isEnglish
                        ? 'You can delete your data anytime'
                        : 'يمكنك حذف بياناتك في أي وقت',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCommitmentCard(
                    icon: Icons.security,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish
                        ? 'Your Data is Yours'
                        : 'بياناتك ملكك',
                    description: widget.isEnglish
                        ? 'Full ownership of your data'
                        : 'ملكية كاملة لبياناتك',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _buildCommitmentCard(
                    icon: Icons.share,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish ? 'No Sharing' : 'لا مشاركة',
                    description: widget.isEnglish
                        ? 'We never sell your data'
                        : 'لا نبيع بياناتك أبداً',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCommitmentCard(
                    icon: Icons.sync,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish ? 'Full Operation' : 'تشغيل كامل',
                    description: widget.isEnglish
                        ? 'Complete control over your data'
                        : 'تحكم كامل في بياناتك',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== تفاصيل السياسة =====
            Text(
              widget.isEnglish ? 'Policy Details' : 'تفاصيل السياسة',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ===== 1. البيانات التي نجمعها (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 1,
              number: '1',
              title: widget.isEnglish
                  ? 'Data We Collect'
                  : 'البيانات التي نجمعها',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEnglish
                        ? 'We collect the following types of data:'
                        : 'نقوم بجمع الأنواع التالية من البيانات:',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(
                    widget.isEnglish
                        ? 'Account data: name, email, phone number, company information.'
                        : 'بيانات الحساب: الاسم، البريد الإلكتروني، رقم الهاتف، معلومات الشركة.',
                  ),
                  _buildBulletPoint(
                    widget.isEnglish
                        ? 'Usage data: how you interact with the app, pages you visit, time spent.'
                        : 'بيانات الاستخدام: كيفية تفاعلك مع التطبيق، الصفحات التي تزورها، الوقت المستغرق.',
                  ),
                  _buildBulletPoint(
                    widget.isEnglish
                        ? 'Device data: device type, operating system, IP address, device ID.'
                        : 'بيانات الجهاز: نوع الجهاز، نظام التشغيل، عنوان IP، معرف الجهاز.',
                  ),
                  _buildBulletPoint(
                    widget.isEnglish
                        ? 'Transaction data: invoices, payments, inventory records.'
                        : 'بيانات المعاملات: الفواتير، المدفوعات، سجلات المخزون.',
                  ),
                  _buildBulletPoint(
                    widget.isEnglish
                        ? 'Location data: only when location-based attendance is enabled.'
                        : 'بيانات الموقع الجغرافي: فقط عند تفعيل خاصية تسجيل الحضور بالموقع.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== 2. كيف نستخدم بياناتك (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 2,
              number: '2',
              title: widget.isEnglish
                  ? 'How We Use Your Data'
                  : 'كيف نستخدم بياناتك',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'We use your data to provide and improve our services, process transactions, communicate with you, and comply with legal obligations. Your data helps us personalize your experience and enhance app functionality.'
                      : 'نستخدم بياناتك لتقديم وتحسين خدماتنا، ومعالجة المعاملات، والتواصل معك، والامتثال للالتزامات القانونية. تساعدنا بياناتك في تخصيص تجربتك وتحسين وظائف التطبيق.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 3. أمان البيانات (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 3,
              number: '3',
              title: widget.isEnglish ? 'Data Security' : 'أمان البيانات',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, or destruction. This includes encryption, access controls, and regular security audits.'
                      : 'ننفذ تدابير تقنية وتنظيمية مناسبة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التعديل أو التدمير. يشمل ذلك التشفير وضوابط الوصول والتدقيق الأمني المنتظم.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 4. مشاركة البيانات (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 4,
              number: '4',
              title: widget.isEnglish ? 'Data Sharing' : 'مشاركة البيانات',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'We do not sell your personal information. We may share information with trusted third parties who assist us in operating our services, subject to confidentiality agreements. This includes payment processors and cloud service providers.'
                      : 'نحن لا نبيع معلوماتك الشخصية. قد نشارك المعلومات مع أطراف ثالثة موثوقة تساعدنا في تشغيل خدماتنا، مع الالتزام باتفاقيات السرية. يشمل ذلك معالجي الدفع ومقدمي خدمات السحابة.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 5. حقوقك (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 5,
              number: '5',
              title: widget.isEnglish ? 'Your Rights' : 'حقوقك',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isEnglish
                          ? 'You have the following rights regarding your personal data:'
                          : 'لديك الحقوق التالية فيما يتعلق ببياناتك الشخصية:',
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint(
                      widget.isEnglish
                          ? 'Right to access your data'
                          : 'حق الوصول إلى بياناتك',
                    ),
                    _buildBulletPoint(
                      widget.isEnglish
                          ? 'Right to correct your data'
                          : 'حق تصحيح بياناتك',
                    ),
                    _buildBulletPoint(
                      widget.isEnglish
                          ? 'Right to delete your data'
                          : 'حق حذف بياناتك',
                    ),
                    _buildBulletPoint(
                      widget.isEnglish
                          ? 'Right to restrict processing'
                          : 'حق تقييد المعالجة',
                    ),
                    _buildBulletPoint(
                      widget.isEnglish
                          ? 'Right to data portability'
                          : 'حق نقل البيانات',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 6. تصدير وحذف بياناتك (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 6,
              number: '6',
              title: widget.isEnglish
                  ? 'Export and Delete Your Data'
                  : 'تصدير وحذف بياناتك',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'You can export your data in common formats (PDF, Excel, CSV) from the settings menu. To delete your account and all associated data, please contact support or use the account deletion option in settings.'
                      : 'يمكنك تصدير بياناتك بصيغ شائعة (PDF, Excel, CSV) من قائمة الإعدادات. لحذف حسابك وجميع البيانات المرتبطة به، يرجى الاتصال بالدعم أو استخدام خيار حذف الحساب في الإعدادات.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 7. ملفات الارتباط والتتبع (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 7,
              number: '7',
              title: widget.isEnglish
                  ? 'Cookies and Tracking'
                  : 'ملفات الارتباط والتتبع',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'We use cookies and similar technologies to improve user experience, analyze traffic, and personalize content. You can control cookie settings through your browser preferences.'
                      : 'نستخدم ملفات الارتباط والتقنيات المشابهة لتحسين تجربة المستخدم وتحليل حركة المرور وتخصيص المحتوى. يمكنك التحكم في إعدادات ملفات الارتباط من خلال تفضيلات المتصفح الخاص بك.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 8. تخزين البيانات ونقلها (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 8,
              number: '8',
              title: widget.isEnglish
                  ? 'Data Storage and Transfer'
                  : 'تخزين البيانات ونقلها',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'Your data is stored on secure servers in multiple regions. We implement appropriate safeguards for international data transfers in compliance with applicable laws.'
                      : 'يتم تخزين بياناتك على خوادم آمنة في مناطق متعددة. ننفذ ضمانات مناسبة لنقل البيانات دولياً وفقاً للقوانين المعمول بها.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 9. التغييرات على سياسة الخصوصية (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 9,
              number: '9',
              title: widget.isEnglish
                  ? 'Changes to Privacy Policy'
                  : 'التغييرات على سياسة الخصوصية',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.isEnglish
                      ? 'We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new policy on this page and updating the "Last Updated" date.'
                      : 'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك بأي تغييرات جوهرية عن طريق نشر السياسة الجديدة على هذه الصفحة وتحديث تاريخ "آخر تحديث".',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== 10. تواصل معنا (قابل للتوسيع) =====
            _buildExpandableSection(
              sectionIndex: 10,
              number: '10',
              title: widget.isEnglish ? 'Contact Us' : 'تواصل معنا',
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.orange.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'privacy@plans.sa',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.orange.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '+966 11 234 5678',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== الامتثال للأنظمة =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade50, Colors.amber.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEnglish
                        ? 'Regulatory Compliance'
                        : 'الامتثال للأنظمة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildComplianceChip('PDPL'),
                      _buildComplianceChip('NCA'),
                      _buildComplianceChip('SOC 2 Type II'),
                      _buildComplianceChip('ISO 27001'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== الفوتر =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade100),
              ),
              child: Column(
                children: [
                  Text(
                    widget.isEnglish ? 'Privacy Policy' : 'سياسة الخصوصية',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Plans ERP',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isEnglish
                        ? '© 2026 Plans. All rights reserved.'
                        : '© 2026 Plans. جميع الحقوق محفوظة.',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== بطاقة الالتزام =====
  Widget _buildCommitmentCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===== قسم قابل للتوسيع =====
  Widget _buildExpandableSection({
    required int sectionIndex,
    required String number,
    required String title,
    required Widget content,
  }) {
    bool isExpanded = _expandedSections.contains(sectionIndex);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // العنوان مع السهم
          InkWell(
            onTap: () => _toggleSection(sectionIndex),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.orange.shade400,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // المحتوى (يظهر عند التوسيع)
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: content,
              ),
            ),
        ],
      ),
    );
  }

  // ===== نقطة تعداد =====
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 14, color: Colors.orange.shade600),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  // ===== شارة الامتثال =====
  Widget _buildComplianceChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.orange.shade700,
        ),
      ),
    );
  }
}
