/// The `expenseType` enum carried by every expense-claim line.
///
/// Codes verified against `POST /hr/expense-claims`, which rejects anything else
/// with:
/// `lines.0.category must be one of the following values: TRAVEL, MEALS,
///  ACCOMMODATION, SUPPLIES, COMMUNICATION, TRAINING, ENTERTAINMENT, OTHER`
///
/// The API only ever returns the English code, so the Arabic label is ours.
enum ExpenseCategory {
  travel('TRAVEL', 'Travel', 'سفر'),
  meals('MEALS', 'Meals', 'وجبات'),
  accommodation('ACCOMMODATION', 'Accommodation', 'إقامة'),
  supplies('SUPPLIES', 'Supplies', 'مستلزمات'),
  communication('COMMUNICATION', 'Communication', 'اتصالات'),
  training('TRAINING', 'Training', 'تدريب'),
  entertainment('ENTERTAINMENT', 'Entertainment', 'ضيافة'),
  other('OTHER', 'Other', 'أخرى');

  const ExpenseCategory(this.code, this.labelEn, this.labelAr);

  /// The value the backend accepts. Never localise this.
  final String code;

  final String labelEn;
  final String labelAr;

  String label(bool isArabic) => isArabic ? labelAr : labelEn;

  /// Resolves a code from the API, or null when it isn't one we know.
  ///
  /// Deliberately nullable rather than defaulting to [other]: the read path
  /// shows the raw code for an unrecognised value, which is more honest than
  /// silently relabelling a new backend category as "Other".
  static ExpenseCategory? tryFromCode(String? code) {
    if (code == null) return null;
    final normalized = code.trim().toUpperCase();
    for (final category in values) {
      if (category.code == normalized) return category;
    }
    return null;
  }
}
