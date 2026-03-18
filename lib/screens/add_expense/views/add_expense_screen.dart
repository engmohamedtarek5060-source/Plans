// screens/add_expense_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saudiaaaa/models/expense_enums.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/attachments_section.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/custom_text_field.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/date_field.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/dropdown_field.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/section_header.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/success_dialog.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/action_buttons.dart';

class AddExpenseScreen extends StatefulWidget {
  final bool isEnglish;

  const AddExpenseScreen({super.key, required this.isEnglish});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String? _selectedCategory;
  String? _selectedPaymentMethod;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _showCategoryDropdown = false;
  bool _showPaymentDropdown = false;
  List<XFile> _selectedFiles = [];

  Future<void> _pickFile() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(images);
      });
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedFiles.add(photo);
      });
    }
  }

  void _showFilePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget.isEnglish ? 'Attach Files' : 'إرفاق ملفات',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.orange),
                title: Text(
                  widget.isEnglish ? 'Choose from Gallery' : 'اختر من المعرض',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.orange),
                title: Text(widget.isEnglish ? 'Take Photo' : 'التقاط صورة'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveExpense() {
    if (_descriptionController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedPaymentMethod == null ||
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEnglish
                ? 'Please fill all required fields'
                : 'الرجاء ملء جميع الحقول المطلوبة',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          isEnglish: widget.isEnglish,
          onDone: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                widget.isEnglish ? Icons.arrow_back : Icons.arrow_forward,
                color: Colors.black87,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              widget.isEnglish ? 'Back' : 'رجوع',
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.isEnglish ? 'Add New Expense' : 'إضافة مصروف جديد',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.isEnglish
                  ? 'Record new expense in system'
                  : 'سجل مصروف جديد في النظام',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    icon: Icons.attach_money,
                    title: widget.isEnglish
                        ? 'Expense Information'
                        : 'معلومات المصروف',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: widget.isEnglish ? 'Description' : 'وصف المصروف',
                    isRequired: true,
                    helperText: widget.isEnglish
                        ? 'Example: Office Rent - February 2026'
                        : 'مثال : ايجار المكتب - فبراير 2026',
                  ),
                  const SizedBox(height: 20),
                  DropdownField(
                    selectedValue: _selectedCategory,
                    items: ExpenseConstants.categories,
                    getItemName: (category) => widget.isEnglish
                        ? (category as Category).nameEn
                        : (category as Category).nameAr,
                    isEnglish: widget.isEnglish,
                    isOpen: _showCategoryDropdown,
                    onToggle: (value) {
                      setState(() {
                        _showCategoryDropdown = value;
                        _showPaymentDropdown = false;
                      });
                    },
                    onSelected: (category) {
                      setState(() {
                        _selectedCategory = widget.isEnglish
                            ? (category as Category).nameEn
                            : (category as Category).nameAr;
                        _showCategoryDropdown = false;
                      });
                    },
                    hintText: widget.isEnglish
                        ? 'Select Category'
                        : 'اختر التصنيف',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DateField(
                          selectedDate: _selectedDate,
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                          isEnglish: widget.isEnglish,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: _amountController,
                          hintText: widget.isEnglish
                              ? 'Amount (SAR)'
                              : 'المبلغ (ريال)',
                          isRequired: true,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SectionHeader(
                    icon: Icons.credit_card,
                    title: widget.isEnglish
                        ? 'Payment Information'
                        : 'معلومات الدفع',
                  ),
                  const SizedBox(height: 20),
                  DropdownField(
                    selectedValue: _selectedPaymentMethod,
                    items: ExpenseConstants.paymentMethods,
                    getItemName: (method) => widget.isEnglish
                        ? (method as PaymentMethod).nameEn
                        : (method as PaymentMethod).nameAr,
                    isEnglish: widget.isEnglish,
                    isOpen: _showPaymentDropdown,
                    onToggle: (value) {
                      setState(() {
                        _showPaymentDropdown = value;
                        _showCategoryDropdown = false;
                      });
                    },
                    onSelected: (method) {
                      setState(() {
                        _selectedPaymentMethod = widget.isEnglish
                            ? (method as PaymentMethod).nameEn
                            : (method as PaymentMethod).nameAr;
                        _showPaymentDropdown = false;
                      });
                    },
                    hintText: widget.isEnglish
                        ? 'Select Payment Method'
                        : 'اختر طريقة الدفع',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _referenceController,
                    hintText: widget.isEnglish
                        ? 'Reference / Invoice Number'
                        : 'المرجع / رقم الفاتورة',
                    helperText: widget.isEnglish
                        ? 'Invoice number or reference for this expense'
                        : 'رقم الفاتورة أو المرجع الخاص بالمصروف',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _supplierController,
                    hintText: widget.isEnglish
                        ? 'Supplier / Company Name'
                        : 'اسم المورد / الجهة',
                  ),
                  const SizedBox(height: 30),
                  SectionHeader(
                    icon: Icons.receipt,
                    title: widget.isEnglish
                        ? 'Additional Information'
                        : 'معلومات إضافية',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _notesController,
                    hintText: widget.isEnglish ? 'Notes' : 'ملاحظات',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  AttachmentsSection(
                    isEnglish: widget.isEnglish,
                    selectedFiles: _selectedFiles,
                    onAttachPressed: _showFilePickerDialog,
                    onFileRemoved: (index) {
                      setState(() {
                        _selectedFiles.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ActionButton(
              isEnglish: widget.isEnglish,
              onSave: _saveExpense,
              onClose: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _referenceController.dispose();
    _supplierController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
