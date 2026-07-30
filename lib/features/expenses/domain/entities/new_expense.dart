import 'package:saudiaaaa/features/expenses/domain/entities/expense_category.dart';

/// One line of a claim being created.
class NewExpenseLine {
  const NewExpenseLine({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  final ExpenseCategory category;
  final String description;
  final double amount;
  final DateTime date;
}

/// The payload for `POST /hr/expense-claims`, as the domain sees it.
///
/// Contract probed 2026-07-30 against the live backend:
/// - `employeeId` (int), `date` (ISO 8601) and `lines` (min 1) are required.
/// - `description` and `projectId` are the only optional top-level fields;
///   `notes`, `title` and `currency` are rejected outright by the DTO whitelist.
/// - each line requires `category`, `date`, `description` (min 2 chars) and
///   `amount` (min 0.01); `receiptUrl`, `taxAmount` and `quantity` are rejected.
class NewExpense {
  const NewExpense({
    required this.employeeId,
    required this.date,
    required this.lines,
    this.description,
  });

  final int employeeId;
  final DateTime date;
  final List<NewExpenseLine> lines;

  /// Optional claim-level note.
  final String? description;

  /// The backend's floor on a line amount.
  static const double minLineAmount = 0.01;

  /// The backend's floor on a line description.
  static const int minDescriptionLength = 2;

  double get total => lines.fold<double>(0, (sum, line) => sum + line.amount);
}
