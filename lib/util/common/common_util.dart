import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CommonUtil {
  static String convertDateDDMMYYYY(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  static generateId() {
    var uuid = const Uuid();
    var v4 = uuid.v4();
    return v4;
  }

  static String getHHmmss(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  static String getjm(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static DateTime convertDDMMYYtoDate(String dateString) {
    final dateInt = dateString.split('-').map((e) => int.parse(e)).toList();
    return DateTime(dateInt[0], dateInt[1], dateInt[2]);
  }

  static String getDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  static DateTime convertStringtoDateTime(String dateTime) {
    return DateFormat('MMM d, yyyy').parse(dateTime);
  }

  static bool isSameDay(DateTime day1, DateTime day2) {
    return day1.day == day2.day &&
        day1.month == day2.month &&
        day1.year == day2.year;
  }
}
