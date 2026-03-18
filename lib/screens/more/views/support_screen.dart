// ==================== support_screen.dart ====================
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  final bool isEnglish;

  const SupportScreen({super.key, required this.isEnglish});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDepartment;
  String? _selectedPriority;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController(text: 'example@company.com');
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _departments = [
    'الدعم الفني',
    'الدعم المالي',
    'الدعم الإداري',
    'شكوى',
    'اقتراح',
  ];

  final List<String> _departmentsEn = [
    'Technical Support',
    'Financial Support',
    'Administrative Support',
    'Complaint',
    'Suggestion',
  ];

  final List<String> _priorities = ['منخفضة', 'متوسطة', 'عالية'];
  final List<String> _prioritiesEn = ['Low', 'Medium', 'High'];

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
          widget.isEnglish ? 'Contact Support' : 'اتصل بالدعم',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
                    widget.isEnglish ? 'Contact Support' : 'اتصل بالدعم',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isEnglish
                        ? 'We are here to help you'
                        : 'نحن هنا لمساعدتك',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== عنوان قنوات التواصل =====
            Text(
              widget.isEnglish ? 'Contact Channels' : 'قنوات التواصل',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ===== بطاقة المحادثة المباشرة =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // أيقونة المحادثة
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat,
                      color: Colors.orange.shade600,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // نص المحادثة
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEnglish ? 'Live Chat' : 'محادثة مباشرة',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.isEnglish ? 'Available Now' : 'متاح الآن',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // حالة متاح
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.isEnglish ? 'Available' : 'متاح',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== بطاقة الاتصال الهاتفي =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // أيقونة الهاتف
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phone,
                      color: Colors.orange.shade600,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // نص الهاتف
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEnglish ? 'Phone Call' : 'اتصال هاتفي',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '+966 11 234 5678',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // نص 24 ساعة
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Text(
                      widget.isEnglish ? '24/7' : '24 ساعة',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== بطاقة البريد الإلكتروني =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // أيقونة البريد
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.orange.shade600,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // نص البريد
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEnglish ? 'Email' : 'البريد الإلكتروني',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'support@plans.sa',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // نص 24 ساعة
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Text(
                      widget.isEnglish ? '24 Hours' : '24 ساعة',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== ساعات الدعم =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // عنوان ساعات الدعم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isEnglish ? 'Support Hours' : 'ساعات الدعم',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // أيام الأحد - الخميس
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isEnglish
                            ? '8:00 AM - 8:00 PM'
                            : '٨:٠٠ ص - ٨:٠٠ م',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.isEnglish
                            ? 'Sunday - Thursday'
                            : 'الأحد - الخميس',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // أيام الجمعة - السبت
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isEnglish
                            ? '10:00 AM - 4:00 PM'
                            : '١٠:٠٠ ص - ٤:٠٠ م',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.isEnglish
                            ? 'Friday - Saturday'
                            : 'الجمعة - السبت',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== إرسال تذكرة دعم =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان إرسال تذكرة
                    Text(
                      widget.isEnglish
                          ? 'Submit Support Ticket'
                          : 'إرسال تذكرة دعم',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // حقل الاسم الكامل
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: widget.isEnglish
                            ? 'Full Name *'
                            : 'الاسم الكامل *',
                        hintText: widget.isEnglish
                            ? 'Enter your full name'
                            : 'أدخل اسمك الكامل',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.amber.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange.shade400),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return widget.isEnglish
                              ? 'Please enter your name'
                              : 'الرجاء إدخال اسمك';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // حقل البريد الإلكتروني
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: widget.isEnglish
                            ? 'Email *'
                            : 'البريد الإلكتروني *',
                        hintText: 'example@company.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.amber.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange.shade400),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return widget.isEnglish
                              ? 'Please enter your email'
                              : 'الرجاء إدخال بريدك الإلكتروني';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // حقل القسم
                    DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: InputDecoration(
                        labelText: widget.isEnglish
                            ? 'Department *'
                            : 'القسم *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.amber.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange.shade400),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      hint: Text(
                        widget.isEnglish ? 'Select department' : 'اختر القسم',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      items: (widget.isEnglish ? _departmentsEn : _departments)
                          .map((department) {
                            return DropdownMenuItem(
                              value: department,
                              child: Text(
                                department,
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            );
                          })
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return widget.isEnglish
                              ? 'Please select a department'
                              : 'الرجاء اختيار القسم';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // حقل الأولوية
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEnglish ? 'Priority *' : 'الأولوية *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children:
                              (widget.isEnglish ? _prioritiesEn : _priorities)
                                  .map((priority) {
                                    bool isSelected =
                                        _selectedPriority == priority;
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedPriority = priority;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.orange.shade50
                                                : Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.orange.shade300
                                                  : Colors.grey.shade300,
                                              width: isSelected ? 2 : 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              priority,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.orange.shade700
                                                    : Colors.grey[600],
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // حقل موضوع الطلب
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: widget.isEnglish
                            ? 'Subject *'
                            : 'موضوع الطلب *',
                        hintText: widget.isEnglish
                            ? 'Brief description of the issue'
                            : 'وصف مختصر للمشكلة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.amber.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange.shade400),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return widget.isEnglish
                              ? 'Please enter the subject'
                              : 'الرجاء إدخال موضوع الطلب';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // حقل تفاصيل المشكلة
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      maxLength: 500,
                      decoration: InputDecoration(
                        labelText: widget.isEnglish
                            ? 'Problem Details *'
                            : 'تفاصيل المشكلة *',
                        hintText: widget.isEnglish
                            ? 'Explain the problem in detail, and mention the steps that led to it...'
                            : 'اشرح المشكلة بالتفصيل، وأذكر الخطوات التي أدت إليها...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.amber.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange.shade400),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                        counterStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return widget.isEnglish
                              ? 'Please enter the problem details'
                              : 'الرجاء إدخال تفاصيل المشكلة';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    // نص المساعدة
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.isEnglish
                                ? 'Your ticket will be answered within 24 working hours.'
                                : 'سيتم الرد على طلبك خلال 24 ساعة عمل.',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.isEnglish
                                ? 'For urgent requests, use live chat or phone call.'
                                : 'للطلبات العاجلة استخدم المحادثة المباشرة أو الاتصال الهاتفي.',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // زر الإرسال
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // إرسال التذكرة
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.isEnglish
                                      ? 'Ticket submitted successfully'
                                      : 'تم إرسال التذكرة بنجاح',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade400,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          widget.isEnglish ? 'Submit Ticket' : 'إرسال التذكرة',
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
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة للحصول على لون الأولوية
  Color _getPriorityColor(String priority) {
    if (priority == 'منخفضة' || priority == 'Low') {
      return Colors.green;
    } else if (priority == 'متوسطة' || priority == 'Medium') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
