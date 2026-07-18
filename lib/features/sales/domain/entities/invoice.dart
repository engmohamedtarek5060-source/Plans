enum InvoiceStatus { paid, pending, overdue }

class Invoice {
  const Invoice({
    required this.rawId,
    required this.id,
    required this.customer,
    required this.customerAr,
    required this.date,
    required this.amount,
    required this.status,
    required this.itemCount,
  });

  /// Numeric backend id, used to fetch the detail (`/sales/invoices/{rawId}`).
  final int rawId;

  /// Human invoice number shown in the UI (e.g. `INV-202607-0001`).
  final String id;
  final String customer;
  final String customerAr;
  final DateTime date;
  final double amount;
  final InvoiceStatus status;
  final int itemCount;
}
