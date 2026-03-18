// ==================== terms_and_conditions_screen.dart ====================
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final bool isEnglish;

  const TermsAndConditionsScreen({super.key, required this.isEnglish});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  // مجموعة لتتبع الأقسام المفتوحة
  final Set<int> _expandedSections = {};

  // قائمة الأقسام
  final List<TermSection> _sections = [
    TermSection(
      number: '1',
      title: 'قبول الشروط',
      titleEn: 'Acceptance of Terms',
      content:
          'باستخدامك لتطبيق Plans ERP، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، يجب عليك عدم استخدام التطبيق.',
      contentEn:
          'By using the Plans ERP application, you agree to be bound by these terms and conditions. If you do not agree to any part of these terms, you should not use the application.',
    ),
    TermSection(
      number: '2',
      title: 'الحسابات والتسجيل',
      titleEn: 'Accounts and Registration',
      content:
          'لإنشاء حساب، يجب أن تكون على الأقل 18 عاماً. أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور. جميع المعلومات التي تقدمها يجب أن تكون دقيقة وكاملة.',
      contentEn:
          'To create an account, you must be at least 18 years old. You are responsible for maintaining the confidentiality of your account information and password. All information you provide must be accurate and complete.',
    ),
    TermSection(
      number: '3',
      title: 'الاشتراك والدفع',
      titleEn: 'Subscription and Payment',
      content:
          'الاشتراك في التطبيق يخضع لرسوم شهرية أو سنوية. يتم الدفع مسبقاً وغير قابل للاسترداد. قد نقوم بتغيير رسوم الاشتراك في المستقبل مع إشعار مسبق.',
      contentEn:
          'Subscription to the application is subject to monthly or annual fees. Payment is prepaid and non-refundable. We may change subscription fees in the future with prior notice.',
    ),
    TermSection(
      number: '4',
      title: 'الاستخدام المقبول',
      titleEn: 'Acceptable Use',
      content:
          'أنت توافق على استخدام التطبيق فقط للأغراض المشروعة ووفقاً لهذه الشروط. لا يجوز لك استخدام التطبيق بأي طريقة تنتهك القوانين المحلية أو الدولية.',
      contentEn:
          'You agree to use the application only for lawful purposes and in accordance with these terms. You may not use the application in any way that violates local or international laws.',
    ),
    TermSection(
      number: '5',
      title: 'البيانات والخصوصية',
      titleEn: 'Data and Privacy',
      content:
          'نحن نأخذ خصوصية بياناتك على محمل الجد. جميع بياناتك مشفرة وآمنة. نحن لا نشارك بياناتك مع أطراف ثالثة دون موافقتك. لمزيد من المعلومات، راجع سياسة الخصوصية الخاصة بنا.',
      contentEn:
          'We take your data privacy seriously. All your data is encrypted and secure. We do not share your data with third parties without your consent. For more information, see our Privacy Policy.',
    ),
    TermSection(
      number: '6',
      title: 'الملكية الفكرية',
      titleEn: 'Intellectual Property',
      content:
          'التطبيق وجميع محتوياته، بما في ذلك النصوص والرسومات والشعارات والبرامج، هي ملك لشركة Plans ومحمية بموجب قوانين الملكية الفكرية.',
      contentEn:
          'The application and all its contents, including text, graphics, logos, and software, are the property of Plans Company and are protected by intellectual property laws.',
    ),
    TermSection(
      number: '7',
      title: 'حدود المسؤولية',
      titleEn: 'Limitation of Liability',
      content:
          'لن تكون شركة Plans مسؤولة عن أي أضرار غير مباشرة أو عرضية أو خاصة أو تبعية تنشأ عن استخدام أو عدم القدرة على استخدام التطبيق.',
      contentEn:
          'Plans Company shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or relating to the use or inability to use the application.',
    ),
    TermSection(
      number: '8',
      title: 'إنهاء الخدمة',
      titleEn: 'Termination of Service',
      content:
          'نحن نحتفظ بالحق في تعليق أو إنهاء وصولك إلى التطبيق في أي وقت، دون إشعار، لأي سبب كان، بما في ذلك انتهاك هذه الشروط.',
      contentEn:
          'We reserve the right to suspend or terminate your access to the application at any time, without notice, for any reason, including violation of these terms.',
    ),
    TermSection(
      number: '9',
      title: 'القانون الحاكم',
      titleEn: 'Governing Law',
      content:
          'تخضع هذه الشروط والأحكام وتفسر وفقاً لقوانين المملكة العربية السعودية، دون النظر إلى مبادئ تنازع القوانين.',
      contentEn:
          'These terms and conditions shall be governed by and construed in accordance with the laws of the Kingdom of Saudi Arabia, without regard to its conflict of law principles.',
    ),
    TermSection(
      number: '10',
      title: 'التواصل معنا',
      titleEn: 'Contact Us',
      content:
          'إذا كان لديك أي أسئلة حول هذه الشروط، يرجى الاتصال بنا عبر البريد الإلكتروني: legal@plans.sa أو من خلال صفحة "اتصل بالدعم" في التطبيق.',
      contentEn:
          'If you have any questions about these terms, please contact us via email: legal@plans.sa or through the "Contact Support" page in the application.',
    ),
  ];

  void _toggleSection(int index) {
    setState(() {
      if (_expandedSections.contains(index)) {
        _expandedSections.remove(index);
      } else {
        _expandedSections.add(index);
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
          widget.isEnglish ? 'Terms & Conditions' : 'الشروط والأحكام',
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
            // ===== عنوان الصفحة الرئيسي =====
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
                    widget.isEnglish ? 'Terms & Conditions' : 'الشروط والأحكام',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isEnglish
                        ? 'Last updated: March 2026'
                        : 'آخر تحديث: مارس 2026',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== عنوان اتفاقية الاستخدام =====
            Text(
              widget.isEnglish
                  ? 'Plans ERP User Agreement'
                  : 'Plans ERP اتفاقية استخدام',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              widget.isEnglish
                  ? 'Please read these terms carefully before using the application'
                  : 'يرجى قراءة هذه الشروط بعناية قبل استخدام التطبيق',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 12),

            // ===== تاريخ السريان وعدد البنود =====
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isEnglish
                                  ? 'Effective Date'
                                  : 'تاريخ السريان',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              widget.isEnglish
                                  ? 'March 1, 2026'
                                  : '1 مارس 2026',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.description,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isEnglish ? 'Sections' : 'بنود',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              widget.isEnglish ? '10 Sections' : '١٠ بنود',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== ملخص النقاط الرئيسية =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEnglish
                        ? 'Key Points Summary'
                        : 'ملخص النقاط الرئيسية',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBulletPoint(
                    icon: Icons.lock,
                    text: widget.isEnglish
                        ? 'Your data is encrypted and completely secure'
                        : 'بياناتك مشفرة وآمنة تماماً',
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(
                    icon: Icons.share,
                    text: widget.isEnglish
                        ? 'We do not share your data with third parties'
                        : 'لا نشارك بياناتك مع أطراف ثالثة',
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(
                    icon: Icons.cancel,
                    text: widget.isEnglish
                        ? 'You can cancel your subscription at any time'
                        : 'يمكنك إلغاء الاشتراك في أي وقت',
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(
                    icon: Icons.support_agent,
                    text: widget.isEnglish
                        ? 'Support available 7 days a week'
                        : 'الدعم متاح ٧ أيام في الأسبوع',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== قائمة الأقسام =====
            ..._sections.asMap().entries.map((entry) {
              int index = entry.key;
              TermSection section = entry.value;
              bool isExpanded = _expandedSections.contains(index);

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade100),
                ),
                child: Column(
                  children: [
                    // عنوان القسم مع السهم
                    ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            section.number,
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        widget.isEnglish ? section.titleEn : section.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.orange.shade400,
                        ),
                        onPressed: () => _toggleSection(index),
                      ),
                    ),

                    // محتوى القسم (يظهر عند التوسيع)
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
                          child: Text(
                            widget.isEnglish
                                ? section.contentEn
                                : section.content,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            // ===== تأكيد القبول =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade50, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    widget.isEnglish
                        ? 'By continuing to use the application, you confirm your acceptance of these terms and conditions.'
                        : 'باستمرار استخدامك للتطبيق، فإنك تؤكد قبولك لهذه الشروط والأحكام.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade800,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== التذييل =====
            Column(
              children: [
                Text(
                  widget.isEnglish
                      ? 'Plans ERP · Terms & Conditions'
                      : 'Plans ERP · الشروط والأحكام',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isEnglish
                      ? '© 2026 Plans. All rights reserved.'
                      : 'Plans 2026 © جميع الحقوق محفوظة',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange.shade600, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.orange.shade800),
          ),
        ),
      ],
    );
  }
}

// ===== نموذج بيانات قسم الشروط =====
class TermSection {
  final String number;
  final String title;
  final String titleEn;
  final String content;
  final String contentEn;

  TermSection({
    required this.number,
    required this.title,
    required this.titleEn,
    required this.content,
    required this.contentEn,
  });
}
