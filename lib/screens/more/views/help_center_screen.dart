// ==================== help_center_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/support_screen.dart';

class HelpCenterScreen extends StatefulWidget {
  final bool isEnglish;

  const HelpCenterScreen({super.key, required this.isEnglish});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  String _selectedCategory = 'الكل';
  final TextEditingController _searchController = TextEditingController();

  // مجموعة لتتبع الأسئلة المفتوحة
  final Set<int> _expandedQuestions = {};

  final List<String> _categories = ['الكل', 'الفواتير', 'الموظفون'];
  final List<String> _categoriesEn = ['All', 'Invoices', 'Employees'];

  // قائمة الأسئلة الشائعة
  final List<FaqItem> _faqItems = [
    FaqItem(
      question: 'كيف أنشئ فاتورة جديدة؟',
      questionEn: 'How do I create a new invoice?',
      answer:
          'لإنشاء فاتورة جديدة، اذهب إلى قائمة "الفواتير" ثم اضغط على زر "فاتورة جديدة" في الأسفل. املأ بيانات العميل والمنتجات ثم اضغط "حفظ".',
      answerEn:
          'To create a new invoice, go to the "Invoices" menu and click the "New Invoice" button at the bottom. Fill in customer and product details, then click "Save".',
      category: 'الفواتير',
    ),
    FaqItem(
      question: 'كيف أسجل دفعة على فاتورة؟',
      questionEn: 'How do I record a payment on an invoice?',
      answer:
          'لتسجيل دفعة، افتح الفاتورة المطلوبة واضغط على "تسجيل دفعة". اختر طريقة الدفع وأدخل المبلغ ثم اضغط "تأكيد".',
      answerEn:
          'To record a payment, open the desired invoice and click "Record Payment". Select payment method and enter amount, then click "Confirm".',
      category: 'الفواتير',
    ),
    FaqItem(
      question: 'كيف أضيف موظفاً جديداً؟',
      questionEn: 'How do I add a new employee?',
      answer:
          'لإضافة موظف جديد، اذهب إلى قائمة "الموظفون" ثم اضغط على زر "إضافة موظف". أدخل بيانات الموظف ثم اضغط "حفظ".',
      answerEn:
          'To add a new employee, go to the "Employees" menu and click the "Add Employee" button. Enter employee details then click "Save".',
      category: 'الموظفون',
    ),
    FaqItem(
      question: 'كيف يسجل الموظف حضوره؟',
      questionEn: 'How does an employee record attendance?',
      answer:
          'يمكن للموظف تسجيل الحضور من خلال تطبيق الموظف أو من خلال شاشة الحضور في لوحة التحكم.',
      answerEn:
          'Employees can record attendance through the employee app or through the attendance screen in the dashboard.',
      category: 'الموظفون',
    ),
    FaqItem(
      question: 'كيف أصدر التقارير المالية؟',
      questionEn: 'How do I generate financial reports?',
      answer:
          'لإصدار التقارير المالية، اذهب إلى قائمة "التقارير" واختر نوع التقرير المطلوب، ثم حدد الفترة الزمنية واضغط "عرض التقرير".',
      answerEn:
          'To generate financial reports, go to the "Reports" menu, select the desired report type, choose the time period, and click "View Report".',
      category: 'الكل',
    ),
    FaqItem(
      question: 'ما هو دفتر الأستاذ العام؟',
      questionEn: 'What is the general ledger?',
      answer:
          'دفتر الأستاذ العام هو سجل يحتوي على جميع المعاملات المالية للشركة، مقسمة حسب الحسابات المختلفة.',
      answerEn:
          'The general ledger is a record containing all financial transactions of the company, divided by different accounts.',
      category: 'الكل',
    ),
    FaqItem(
      question: 'كيف أغير اللغة؟',
      questionEn: 'How do I change the language?',
      answer:
          'لتغيير اللغة، اذهب إلى قائمة "المزيد" ثم "الإعدادات" واختر اللغة المفضلة لديك.',
      answerEn:
          'To change the language, go to the "More" menu, then "Settings", and select your preferred language.',
      category: 'الكل',
    ),
    FaqItem(
      question: 'كيف أفعل المصادقة البيومترية؟',
      questionEn: 'How do I enable biometric authentication?',
      answer:
          'لفعل المصادقة البيومترية، اذهب إلى "الإعدادات" ثم "الأمان" وفعل خيار "البصمة" أو "الوجه".',
      answerEn:
          'To enable biometric authentication, go to "Settings", then "Security", and enable "Fingerprint" or "Face ID".',
      category: 'الكل',
    ),
    FaqItem(
      question: 'كيف أضيف منتجاً جديداً؟',
      questionEn: 'How do I add a new product?',
      answer:
          'لإضافة منتج جديد، اذهب إلى قائمة "المنتجات" ثم اضغط على زر "إضافة منتج". أدخل بيانات المنتج ثم اضغط "حفظ".',
      answerEn:
          'To add a new product, go to the "Products" menu and click the "Add Product" button. Enter product details then click "Save".',
      category: 'الكل',
    ),
    FaqItem(
      question: 'كيف أتلقى تنبيهات نفاد المخزون؟',
      questionEn: 'How do I receive low stock alerts?',
      answer:
          'يمكنك تفعيل تنبيهات نفاد المخزون من خلال "الإعدادات" ثم "التنبيهات" وتفعيل خيار "نفاد المخزون".',
      answerEn:
          'You can enable low stock alerts through "Settings", then "Alerts", and enable the "Low Stock" option.',
      category: 'الكل',
    ),
  ];

  List<FaqItem> get filteredFaqs {
    if (_selectedCategory == 'الكل' || _selectedCategory == 'All') {
      return _faqItems;
    }
    return _faqItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  void _toggleQuestion(int index) {
    setState(() {
      if (_expandedQuestions.contains(index)) {
        _expandedQuestions.remove(index);
      } else {
        _expandedQuestions.add(index);
      }
    });
  }

  void _navigateToSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupportScreen(isEnglish: widget.isEnglish),
      ),
    );
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
          widget.isEnglish ? 'Help Center' : 'مركز المساعدة',
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
            // ===== عنوان الصفحة الترحيبي =====
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
                    widget.isEnglish ? 'Help Center' : 'مركز المساعدة',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isEnglish
                        ? 'Search FAQs and resources'
                        : 'ابحث في الأسئلة الشائعة والموارد',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== قسم كيف يمكننا مساعدتك =====
            Text(
              widget.isEnglish ? 'How can we help you?' : 'كيف يمكننا مساعدتك؟',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              widget.isEnglish
                  ? 'Search the knowledge base or browse FAQs'
                  : 'ابحث في قاعدة المعرفة أو تصفح الأسئلة الشائعة',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 16),

            // ===== شريط البحث =====
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade100),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.isEnglish
                      ? 'Search for a question...'
                      : 'ابحث عن سؤال...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orange.shade400,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  // implement search
                },
              ),
            ),

            const SizedBox(height: 24),

            // ===== روابط سريعة =====
            Text(
              widget.isEnglish ? 'Quick Links' : 'روابط سريعة',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // رابط اتصل بنا
            Row(
              children: [
                Expanded(
                  child: _buildQuickLinkCard(
                    icon: Icons.headset_mic,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish ? 'Contact Us' : 'اتصل بنا',
                    subtitle: widget.isEnglish
                        ? 'Contact Support'
                        : 'اتصل بالدعم',
                    onTap: _navigateToSupport,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickLinkCard(
                    icon: Icons.menu_book,
                    iconColor: Colors.orange.shade600,
                    title: widget.isEnglish ? 'User Guide' : 'دليل المستخدم',
                    subtitle: widget.isEnglish ? 'Tutorials' : 'مقاطع تعليمية',
                    onTap: () {
                      // Navigate to user guide
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== تصفح حسب الفئة =====
            Text(
              widget.isEnglish ? 'Browse by Category' : 'تصفح حسب الفئة',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ===== أزرار التصنيفات =====
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (widget.isEnglish ? _categoriesEn : _categories).map((
                  category,
                ) {
                  bool isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange.shade400
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.orange.shade400
                              : Colors.amber.shade200,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // ===== عنوان الأسئلة الشائعة =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredFaqs.length} ${widget.isEnglish ? 'Questions' : 'سؤال'}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  widget.isEnglish
                      ? 'Frequently Asked Questions'
                      : 'الأسئلة الشائعة',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== قائمة الأسئلة الشائعة =====
            ...filteredFaqs.asMap().entries.map((entry) {
              int index = entry.key;
              FaqItem faq = entry.value;
              bool isExpanded = _expandedQuestions.contains(index);

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade100),
                ),
                child: Column(
                  children: [
                    // السؤال
                    ListTile(
                      title: Text(
                        widget.isEnglish ? faq.questionEn : faq.question,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                        onPressed: () => _toggleQuestion(index),
                      ),
                    ),

                    // الإجابة (تظهر عند التوسيع)
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
                            widget.isEnglish ? faq.answerEn : faq.answer,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 24),

            // ===== رسالة لم تجد ما تبحث عنه =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    widget.isEnglish
                        ? "Didn't find what you're looking for?"
                        : 'لم تجد ما تبحث عنه؟',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isEnglish
                        ? 'Our support team is ready to help you 24/7'
                        : 'فريق الدعم جاهز لمساعدتك على مدار الساعة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToSupport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        widget.isEnglish ? 'Contact Support' : 'تواصل مع الدعم',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

  Widget _buildQuickLinkCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
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
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== نموذج بيانات الأسئلة الشائعة =====
class FaqItem {
  final String question;
  final String questionEn;
  final String answer;
  final String answerEn;
  final String category;

  FaqItem({
    required this.question,
    required this.questionEn,
    required this.answer,
    required this.answerEn,
    required this.category,
  });
}
