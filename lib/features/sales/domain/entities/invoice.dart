enum InvoiceStatus { paid, pending, overdue }

class Invoice {
  const Invoice({
    required this.id,
    required this.customer,
    required this.customerAr,
    required this.date,
    required this.amount,
    required this.status,
    required this.itemCount,
  });

  final String id;
  final String customer;
  final String customerAr;
  final DateTime date;
  final double amount;
  final InvoiceStatus status;
  final int itemCount;
}
