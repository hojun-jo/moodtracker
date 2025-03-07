import 'package:intl/intl.dart';

abstract class DateFormater {
  DateFormater._();

  static String format(DateTime date) {
    return DateFormat.MMMEd().format(date);
  }
}
