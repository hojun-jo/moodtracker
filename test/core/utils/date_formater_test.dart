import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/core/utils/date_formater.dart';

void main() {
  group('formatMoodCard', () {
    test('should format date correctly for a normal date', () {
      // given
      final date = DateTime(2024, 3, 15); // March 15, 2024

      // when
      final result = DateFormater.formatMoodCard(date);

      // then
      expect(result, 'Fri, Mar 15');
    });

    test('should format date correctly for the first day of month', () {
      // given
      final date = DateTime(2024, 3, 1); // March 1, 2024

      // when
      final result = DateFormater.formatMoodCard(date);

      // then
      expect(result, 'Fri, Mar 1');
    });

    test('should format date correctly for the last day of month', () {
      // given
      final date = DateTime(2024, 2, 29); // February 29, 2024 (leap year)

      // when
      final result = DateFormater.formatMoodCard(date);

      // then
      expect(result, 'Thu, Feb 29');
    });

    test('should format date correctly for the first day of year', () {
      // given
      final date = DateTime(2024, 1, 1); // January 1, 2024

      // when
      final result = DateFormater.formatMoodCard(date);

      // then
      expect(result, 'Mon, Jan 1');
    });

    test('should format date correctly for the last day of year', () {
      // given
      final date = DateTime(2024, 12, 31); // December 31, 2024

      // when
      final result = DateFormater.formatMoodCard(date);

      // then
      expect(result, 'Tue, Dec 31');
    });
  });
}
