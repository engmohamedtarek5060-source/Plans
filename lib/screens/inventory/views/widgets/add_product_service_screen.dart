// screens/add_product/add_product_service_screen.dart
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/main_layout.dart';

class AddProductServiceScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const AddProductServiceScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  State<AddProductServiceScreen> createState() =>
      _AddProductServiceScreenState();
}

class _AddProductServiceScreenState extends State<AddProductServiceScreen> {
  // متغير لتحديد نوع العنصر (منتج أو خدمة)
  String _selectedType = 'product'; // 'product' or 'service'
  int _currentIndex = 1; // مؤشر المخزون

  // متغيرات لحقول النموذج
  final TextEditingController _nameArController = TextEditingController();
  final TextEditingController _nameEnController = TextEditingController();
  final TextEditingController _skuController = TextEditingController(
    text: 'PRD-001',
  );
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController(
    text: '0.00',
  );
  final TextEditingController _quantityController = TextEditingController(
    text: '0',
  );
  final TextEditingController _reorderPointController = TextEditingController(
    text: '0',
  );
  final TextEditingController _descriptionArController =
      TextEditingController();
  final TextEditingController _descriptionEnController =
      TextEditingController();

  // متغير للضريبة
  String _selectedTax = '15%';

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // هنا يمكن إضافة التنقل بناءً على index
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isEnglish: widget.isEnglish,
      selectedBranch: widget.initialBranch,
      notificationCount: widget.initialNotificationCount,
      onBranchTap: () {
        // منطق اختيار الفرع
        print('Branch tapped');
      },
      onNotificationsTap: () {
        // منطق عرض الإشعارات
        print('Notifications tapped');
      },
      currentIndex: _currentIndex,
      onNavItemTapped: _onNavItemTapped,
      showAppBar: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // App Bar الداخلي
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // زر الرجوع
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          widget.isEnglish
                              ? Icons.arrow_back
                              : Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      // العنوان
                      Text(
                        widget.isEnglish
                            ? 'Add New Product'
                            : 'إضافة منتج جديد',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // نوع العنصر
                      Text(
                        widget.isEnglish ? 'Item Type' : 'نوع العنصر',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // اختيار نوع العنصر
                      Row(
                        children: [
                          // كونتينر الخدمة
                          Expanded(
                            child: _buildTypeCard(
                              isSelected: _selectedType == 'service',
                              icon: Icons.label_outline,
                              title: widget.isEnglish ? 'Service' : 'خدمة',
                              subtitle: widget.isEnglish
                                  ? 'Non-physical service'
                                  : 'خدمة غير مادية',
                              onTap: () =>
                                  setState(() => _selectedType = 'service'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // كونتينر المنتج
                          Expanded(
                            child: _buildTypeCard(
                              isSelected: _selectedType == 'product',
                              icon: Icons.crop_square,
                              title: widget.isEnglish ? 'Product' : 'منتج',
                              subtitle: widget.isEnglish
                                  ? 'Physical storable item'
                                  : 'سلعة مادية قابلة للتخزين',
                              onTap: () =>
                                  setState(() => _selectedType = 'product'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // المعلومات الأساسية
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // عنوان القسم مع الأيقونة
                            Row(
                              children: [
                                Icon(
                                  _selectedType == 'product'
                                      ? Icons.crop_square
                                      : Icons.label_outline,
                                  color: Colors.orange,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.isEnglish
                                      ? 'Basic Information'
                                      : 'المعلومات الأساسية',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // حقول المعلومات الأساسية
                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'Name (Arabic) *'
                                  : 'الاسم بالعربية *',
                              hint: widget.isEnglish
                                  ? 'Enter product name in Arabic'
                                  : 'أدخل اسم المنتج بالعربية',
                              controller: _nameArController,
                            ),
                            const SizedBox(height: 16),

                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'Name (English)'
                                  : 'الاسم بالإنجليزية',
                              hint: widget.isEnglish
                                  ? 'Enter name in English'
                                  : 'Enter name in English',
                              controller: _nameEnController,
                            ),
                            const SizedBox(height: 16),

                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'SKU *'
                                  : 'رمز المنتج (SKU) *',
                              hint: 'PRD-001',
                              controller: _skuController,
                            ),
                            const SizedBox(height: 16),

                            _buildTextField(
                              label: widget.isEnglish ? 'Category' : 'الفئة',
                              hint: widget.isEnglish
                                  ? 'Select category'
                                  : 'اختر الفئة',
                              controller: _categoryController,
                              suffixIcon: Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // التسعير
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // عنوان القسم
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.orange,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.isEnglish ? 'Pricing' : 'التسعير',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // سعر الوحدة
                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'Unit Price (SAR) *'
                                  : 'سعر الوحدة (ريال) *',
                              hint: '0.00',
                              controller: _unitPriceController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),

                            // الضريبة - تم تعديلها
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.isEnglish
                                      ? 'Tax Rate (%)'
                                      : 'نسبة الضريبة (%)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedTax,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: _getTaxItems(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedTax = newValue!;
                                        });
                                      },
                                      hint: Text(
                                        widget.isEnglish
                                            ? 'Select tax rate'
                                            : 'اختر نسبة الضريبة',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // المخزون (يظهر فقط للمنتجات)
                      if (_selectedType == 'product') ...[
                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // عنوان القسم
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.inventory_2_outlined,
                                      color: Colors.orange,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.isEnglish ? 'Inventory' : 'المخزون',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // الكمية الحالية
                              _buildTextField(
                                label: widget.isEnglish
                                    ? 'Current Quantity'
                                    : 'الكمية الحالية',
                                hint: '0',
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 16),

                              // حد إعادة الطلب
                              _buildTextField(
                                label: widget.isEnglish
                                    ? 'Reorder Point'
                                    : 'حد إعادة الطلب',
                                hint: '0',
                                controller: _reorderPointController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Text(
                                widget.isEnglish
                                    ? 'You will be notified when stock reaches this level or below'
                                    : 'سيتم تنبيهك عندما تصل الكمية إلى هذا الحد أو أقل',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // الوصف
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // عنوان القسم
                            Row(
                              children: [
                                const Icon(
                                  Icons.description_outlined,
                                  color: Colors.orange,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.isEnglish ? 'Description' : 'الوصف',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // الوصف بالعربية
                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'Description (Arabic)'
                                  : 'الوصف بالعربية',
                              hint: widget.isEnglish
                                  ? 'Enter detailed description in Arabic'
                                  : 'أدخل وصفاً تفصيلياً بالعربية',
                              controller: _descriptionArController,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),

                            // الوصف بالإنجليزية
                            _buildTextField(
                              label: widget.isEnglish
                                  ? 'Description (English)'
                                  : 'الوصف بالإنجليزية',
                              hint: widget.isEnglish
                                  ? 'Enter detailed description in English'
                                  : 'Enter detailed description in English',
                              controller: _descriptionEnController,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // الحالة (نشط/متاح)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // المربع البرتقالي مع علامة الصح
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            // النصوص
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.isEnglish ? 'Active' : 'نشط',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.isEnglish
                                      ? 'Available for use in invoices'
                                      : 'متاح للاستخدام في الفواتير',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // زر الإضافة
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // هنا هتضيف منطق حفظ المنتج/الخدمة
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.isEnglish
                                      ? 'Item added successfully'
                                      : 'تمت الإضافة بنجاح',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            widget.isEnglish ? 'Add' : 'إضافة',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة لبناء بطاقة نوع العنصر
  Widget _buildTypeCard({
    required bool isSelected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.orange : Colors.grey[400],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.orange : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.orange.shade300 : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // دالة للحصول على عناصر الضريبة
  List<DropdownMenuItem<String>> _getTaxItems() {
    if (widget.isEnglish) {
      return [
        const DropdownMenuItem<String>(
          value: '15%',
          child: Text('15% (VAT)', textAlign: TextAlign.right),
        ),
        const DropdownMenuItem<String>(
          value: '0%',
          child: Text('Tax Exempt (0%)', textAlign: TextAlign.right),
        ),
        const DropdownMenuItem<String>(
          value: '5%',
          child: Text('5%', textAlign: TextAlign.right),
        ),
      ];
    } else {
      return [
        const DropdownMenuItem<String>(
          value: '15%',
          child: Text('15% (ضريبة القيمة المضافة)', textAlign: TextAlign.right),
        ),
        const DropdownMenuItem<String>(
          value: '0%',
          child: Text('معفي من الضريبة (0%)', textAlign: TextAlign.right),
        ),
        const DropdownMenuItem<String>(
          value: '5%',
          child: Text('5%', textAlign: TextAlign.right),
        ),
      ];
    }
  }

  // دالة لبناء حقول النص
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey[600])
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // تنظيف المتحكمات
    _nameArController.dispose();
    _nameEnController.dispose();
    _skuController.dispose();
    _categoryController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _reorderPointController.dispose();
    _descriptionArController.dispose();
    _descriptionEnController.dispose();
    super.dispose();
  }
}
