class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.category,
    required this.categoryAr,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.paymentMethodAr,
  });

  final String id;
  final String title;
  final String titleAr;
  final String category;
  final String categoryAr;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String paymentMethodAr;
}
