import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/invoice/views/invoice_review_screen.dart';
import 'package:saudiaaaa/screens/invoice/views/product_selection_screen.dart';
import 'package:saudiaaaa/screens/invoice/views/widgets/customer_selection_screen.dart';

class AddInvoiceScreen extends StatefulWidget {
  final bool isEnglish;

  const AddInvoiceScreen({super.key, required this.isEnglish});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  int _currentStep = 1;
  Map<String, dynamic>? _selectedCustomer;
  Map<String, dynamic>? _selectedProduct;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _completeInvoice() {
    // Go back to home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
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
        title: Text(
          widget.isEnglish ? 'Create New Invoice' : 'إنشاء فاتورة جديدة',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_currentStep) {
      case 1:
        return CustomerSelectionScreen(
          isEnglish: widget.isEnglish,
          onNext: (selectedCustomer) {
            setState(() {
              _selectedCustomer = selectedCustomer;
              _nextStep();
            });
          },
        );
      case 2:
        return ProductSelectionScreen(
          isEnglish: widget.isEnglish,
          onNext: (selectedProduct) {
            setState(() {
              _selectedProduct = selectedProduct;
              _nextStep();
            });
          },
          onPrevious: _previousStep,
        );
      case 3:
        if (_selectedCustomer != null && _selectedProduct != null) {
          return InvoiceReviewScreen(
            isEnglish: widget.isEnglish,
            selectedCustomer: _selectedCustomer!,
            selectedProduct: _selectedProduct!,
            onPrevious: _previousStep,
            onComplete: _completeInvoice,
          );
        }
        return const SizedBox.shrink();
      default:
        return Container();
    }
  }
}
