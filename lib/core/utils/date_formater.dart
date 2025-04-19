import 'package:intl/intl.dart';

abstract class DateFormater {
  DateFormater._();

  static String formatMoodCard(DateTime date) {
    return DateFormat.MMMEd().format(date);
  }
}
