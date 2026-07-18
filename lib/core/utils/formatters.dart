import 'package:intl/intl.dart';

abstract final class Formatters {
  static String currency(num amount, {required String locale}) {
    return NumberFormat.currency(
      locale: locale == 'ar' ? 'ar_SA' : 'en_US',
      symbol: locale == 'ar' ? 'ر.س' : 'SAR ',
      decimalDigits: 0,
    ).format(amount);
  }

  static String compact(num value, {required String locale}) {
    return NumberFormat.compact(locale: locale == 'ar' ? 'ar' : 'en')
        .format(value);
  }

  /// Signed amount ("+8,500 ر.س") built from parts so no bidi marks from
  /// intl can push the sign to the wrong side. Render inside a
  /// `Text(textDirection: TextDirection.ltr)`.
  static String signedCurrency(
    num amount, {
    required String locale,
    required bool positive,
  }) {
    final digits = NumberFormat.decimalPattern('en').format(amount);
    final symbol = locale == 'ar' ? 'ر.س' : 'SAR';
    return '${positive ? '+' : '-'}$digits $symbol';
  }

  static String percent(double value, {required String locale}) {
    return NumberFormat.decimalPercentPattern(
      locale: locale == 'ar' ? 'ar' : 'en',
      decimalDigits: 1,
    ).format(value);
  }

  /// Short date, e.g. "17 Jul 2026".
  static String date(DateTime value, {required String locale}) {
    return DateFormat.yMMMd(locale == 'ar' ? 'ar' : 'en').format(value);
  }
}
