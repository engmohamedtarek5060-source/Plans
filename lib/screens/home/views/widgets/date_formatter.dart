import 'package:intl/intl.dart';

class DateFormatter {
  static String getCurrentDate(bool isEnglish, bool isDateFormatInitialized) {
    if (isDateFormatInitialized) {
      return isEnglish
          ? DateFormat('EEEE, d MMMM').format(DateTime.now())
          : DateFormat('EEEE, d MMMM', 'ar').format(DateTime.now());
    } else {
      return _getFormattedDate(isEnglish);
    }
  }

  static String _getFormattedDate(bool isEnglish) {
    final now = DateTime.now();

    if (isEnglish) {
      final days = [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
      ];
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
    } else {
      final days = [
        'الأحد',
        'الإثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
      ];
      final months = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];
      return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
    }
  }
}
