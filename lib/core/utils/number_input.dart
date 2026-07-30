/// Parsing for user-typed numbers.
///
/// `double.tryParse` only accepts ASCII digits and a `.` separator. This app is
/// Arabic-first, and an Arabic keyboard produces Arabic-Indic digits (`٠١٢`) and
/// the Arabic decimal separator (`٫`), so a perfectly valid amount typed in
/// Arabic would otherwise fail to parse — the field would reject every entry
/// with no way for the user to tell why.
///
/// Validation and submission must both go through here so the value that passes
/// the form is exactly the value that gets sent.
library;

/// Arabic-Indic digits, indexed by their value.
const String _arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';

/// Extended (Persian/Urdu) Arabic-Indic digits, which some keyboards emit.
const String _extendedArabicIndicDigits = '۰۱۲۳۴۵۶۷۸۹';

/// Normalises [raw] to a string `double.tryParse` understands.
///
/// Converts Arabic-Indic digits to ASCII, maps the Arabic decimal separator to
/// `.`, and drops grouping separators (`,` and `٬`) so "1,500.50" parses.
String normalizeNumberInput(String raw) {
  final buffer = StringBuffer();

  for (final rune in raw.trim().runes) {
    final char = String.fromCharCode(rune);

    final arabicIndex = _arabicIndicDigits.indexOf(char);
    if (arabicIndex >= 0) {
      buffer.write(arabicIndex);
      continue;
    }

    final extendedIndex = _extendedArabicIndicDigits.indexOf(char);
    if (extendedIndex >= 0) {
      buffer.write(extendedIndex);
      continue;
    }

    // Arabic decimal separator -> the one Dart parses.
    if (char == '٫') {
      buffer.write('.');
      continue;
    }

    // Grouping separators carry no value; strip rather than reject.
    if (char == ',' || char == '٬' || char == '_' || char == ' ') continue;

    buffer.write(char);
  }

  return buffer.toString();
}

/// Parses a money amount typed by the user, or null when it isn't a number.
///
/// Returns null for negatives too: every amount this app submits is a positive
/// figure, and a leading `-` is far more likely to be a typo than an intent.
double? parseAmountInput(String? raw) {
  if (raw == null) return null;
  final normalized = normalizeNumberInput(raw);
  if (normalized.isEmpty) return null;
  final parsed = double.tryParse(normalized);
  if (parsed == null || parsed.isNaN || parsed.isInfinite) return null;
  if (parsed < 0) return null;
  return parsed;
}

/// Parses a whole-number input (a reorder point, a quantity).
int? parseIntInput(String? raw) {
  if (raw == null) return null;
  final normalized = normalizeNumberInput(raw);
  if (normalized.isEmpty) return null;
  final parsed = int.tryParse(normalized);
  if (parsed == null || parsed < 0) return null;
  return parsed;
}
