import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartDateRangeRepository extends Notifier<DateTimeRange> {
  @override
  DateTimeRange build() {
    final now = DateTime.now();

    return DateTimeRange(
      start: DateTime(now.year, now.month),
      end: now,
    );
  }

  void setChartDate(DateTime date) {
    state = DateTimeRange(
      start: DateTime(date.year, date.month),
      end: DateTime(date.year, date.month + 1, 0),
    );
  }
}
