import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';

class AddCustomerScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const AddCustomerScreen({
    super.key,
    required this.isEnglish,
    required this.initialBranch,
    required this.initialNotificationCount,
  });

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  int _currentIndex = 0;

  // متغيرات التحكم في الحقول
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _arabicAddressController =
      TextEditingController();
  final TextEditingController _englishAddressController =
      TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();

  // متغير لشروط الدفع
  String _selectedPaymentTerm = '30 يوم';

  // قائمة شروط الدفع
  final List<String> _paymentTermsArabic = [
    'نقداً',
    '7 أيام',
    '15 يوم',
    '30 يوم',
    '60 يوم',
    '90 يوم',
  ];
  final List<String> _paymentTermsEnglish = [
    'Cash',
    '7 Days',
    '15 Days',
    '30 Days',
    '60 Days',
    '90 Days',
  ];

  @override
  void dispose() {
    _arabicNameController.dispose();
    _englishNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _taxNumberController.dispose();
    _arabicAddressController.dispose();
    _englishAddressController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index != 0) {
      Navigator.pop(context);
    }
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onAddCustomerPressed() {
    // هنا هنضيف منطق حفظ العميل في قاعدة البيانات

    // عرض رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.isEnglish
                    ? 'Customer added successfully!'
                    : 'تمت إضافة العميل بنجاح!',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );

    // الرجوع للصفحة الرئيسية بعد ثانية
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: true,
      isEnglish: widget.isEnglish,
      selectedBranch: widget.initialBranch,
      notificationCount: widget.initialNotificationCount,
      onBranchTap: () {},
      onNotificationsTap: () {},
      currentIndex: _currentIndex,
      onNavItemTapped: _onNavItemTapped,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Directionality(
      textDirection: widget.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // الهيدر مع زر الرجوع
              _buildHeader(),
              const SizedBox(height: 24),

              // الكونتينر الأول - المعلومات الأساسية
              _buildBasicInfoCard(),
              const SizedBox(height: 16),

              // الكونتينر الثاني - معلومات الاتصال والرقم الضريبي
              _buildContactInfoCard(),
              const SizedBox(height: 16),

              // الكونتينر الثالث - العنوان
              _buildAddressCard(),
              const SizedBox(height: 16),

              // الكونتينر الرابع - المعلومات المالية
              _buildFinancialInfoCard(),
              const SizedBox(height: 24),

              // زر إضافة عميل
              _buildAddButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // زر الرجوع
        GestureDetector(
          onTap: _onBackPressed,
          child: Row(
            children: [
              Icon(
                widget.isEnglish ? Icons.arrow_back : Icons.arrow_forward,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 4),
              Text(
                widget.isEnglish ? 'Back' : 'رجوع',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // عنوان الصفحة
        Text(
          widget.isEnglish ? 'Add New Customer' : 'إضافة عميل جديد',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // الكونتينر الأول - المعلومات الأساسية
  Widget _buildBasicInfoCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد مع الأيقونة
          Row(
            children: [
              Icon(Icons.person, color: Colors.red.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                widget.isEnglish ? 'Basic Information' : 'المعلومات الأساسية',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // الاسم بالعربية
          _buildLabel(
            widget.isEnglish ? 'Name in Arabic *' : 'الاسم بالعربية *',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _arabicNameController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? 'Enter customer name in Arabic'
                  : 'أدخل اسم العميل بالعربية',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),

          // الاسم بالإنجليزية
          _buildLabel(
            widget.isEnglish ? 'Name in English' : 'الاسم بالإنجليزية',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _englishNameController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? 'Enter customer name in English'
                  : 'أدخل اسم العميل بالإنجليزية',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  // الكونتينر الثاني - معلومات الاتصال
  Widget _buildContactInfoCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد مع الأيقونة
          Row(
            children: [
              Icon(Icons.phone, color: Colors.red.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                widget.isEnglish ? 'Contact Information' : 'معلومات الاتصال',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // رقم الهاتف
          _buildLabel(widget.isEnglish ? 'Phone Number *' : 'رقم الهاتف *'),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: widget.isEnglish ? '+966 50 123 4567' : '٠٥٠ ١٢٣ ٤٥٦٧',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          // البريد الإلكتروني
          _buildLabel(widget.isEnglish ? 'Email' : 'البريد الإلكتروني'),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? 'customer@example.com'
                  : 'customer@example.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          // الرقم الضريبي
          _buildLabel(widget.isEnglish ? 'Tax Number' : 'الرقم الضريبي'),
          const SizedBox(height: 8),
          TextField(
            controller: _taxNumberController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? '300000000000003'
                  : '٣٠٠٠٠٠٠٠٠٠٠٠٠٠٣',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  // الكونتينر الثالث - العنوان
  Widget _buildAddressCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد مع الأيقونة
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                widget.isEnglish ? 'Address' : 'العنوان',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // العنوان بالعربية
          _buildLabel(
            widget.isEnglish ? 'Address in Arabic' : 'العنوان بالعربية',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _arabicAddressController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? 'Enter address in Arabic'
                  : 'أدخل العنوان بالعربية',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),

          // العنوان بالإنجليزية
          _buildLabel(
            widget.isEnglish ? 'Address in English' : 'العنوان بالإنجليزية',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _englishAddressController,
            decoration: InputDecoration(
              hintText: widget.isEnglish
                  ? 'Enter address in English'
                  : 'أدخل العنوان بالإنجليزية',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  // الكونتينر الرابع - المعلومات المالية
  Widget _buildFinancialInfoCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد مع الأيقونة
          Row(
            children: [
              Icon(Icons.credit_card, color: Colors.red.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                widget.isEnglish
                    ? 'Financial Information'
                    : 'المعلومات المالية',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // الحد الائتماني
          _buildLabel(
            widget.isEnglish ? 'Credit Limit (SAR)' : 'الحد الائتماني (ريال)',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _creditLimitController,
            decoration: InputDecoration(
              hintText: widget.isEnglish ? '100000' : '١٠٠٠٠٠',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // شروط الدفع - Dropdown
          _buildLabel(widget.isEnglish ? 'Payment Terms' : 'شروط الدفع'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedPaymentTerm,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              items: widget.isEnglish
                  ? _paymentTermsEnglish.map((term) {
                      return DropdownMenuItem(value: term, child: Text(term));
                    }).toList()
                  : _paymentTermsArabic.map((term) {
                      return DropdownMenuItem(value: term, child: Text(term));
                    }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentTerm = value!;
                });
              },
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _onAddCustomerPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.isEnglish ? 'Add Customer' : 'إضافة عميل',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
