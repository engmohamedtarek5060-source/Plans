import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';

/// A line item on an invoice.
class InvoiceLine {
  const InvoiceLine({
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.vatAmount,
    required this.total,
  });

  final String description;
  final double quantity;
  final double unitPrice;
  final double vatAmount;
  final double total;
}

/// The full invoice, as shown on the detail screen — richer than the list
/// [Invoice], with line items, customer contact, and the totals breakdown.
class InvoiceDetail {
  const InvoiceDetail({
    required this.number,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.date,
    required this.dueDate,
    required this.status,
    required this.subtotal,
    required this.vatAmount,
    required this.discount,
    required this.total,
    required this.paidAmount,
    required this.notes,
    required this.lines,
  });

  final String number;
  final String customerName;
  final String? customerEmail;
  final String? customerPhone;
  final DateTime date;
  final DateTime? dueDate;
  final InvoiceStatus status;
  final double subtotal;
  final double vatAmount;
  final double discount;
  final double total;
  final double paidAmount;
  final String? notes;
  final List<InvoiceLine> lines;

  /// Amount still owed.
  double get balanceDue => (total - paidAmount).clamp(0, double.infinity);
}
