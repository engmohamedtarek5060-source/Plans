import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';

/// Serialises a [NewExpense] for `POST /hr/expense-claims`.
///
/// The DTO whitelist is strict — an unknown property fails the whole request
/// with `property X should not exist` — so optional fields are omitted entirely
/// rather than sent as null.
class NewExpensePayload {
  const NewExpensePayload._();

  /// Formats a calendar day as a UTC-midnight instant.
  ///
  /// Sending `toUtc()` on a local midnight would shift the day backwards for any
  /// positive offset (Riyadh is UTC+3, so local midnight is 21:00 the previous
  /// day in UTC) and file the claim against the wrong date. Pinning the chosen
  /// year/month/day to UTC midnight keeps the calendar date the user picked.
  static String _isoDay(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day).toIso8601String();

  static Map<String, dynamic> toJson(NewExpense expense) {
    final description = expense.description?.trim();

    return <String, dynamic>{
      'employeeId': expense.employeeId,
      'date': _isoDay(expense.date),
      if (description != null && description.isNotEmpty)
        'description': description,
      'lines': [
        for (final line in expense.lines)
          <String, dynamic>{
            'category': line.category.code,
            'date': _isoDay(line.date),
            'description': line.description.trim(),
            'amount': line.amount,
          },
      ],
    };
  }
}
