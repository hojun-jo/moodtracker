import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/chart/providers/provider.dart';

class MonthPickerDialog extends ConsumerWidget {
  const MonthPickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateList = _monthPickerDateList();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: i18n
            const Text("Choose month"),
            SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  final data = dateList[index];

                  return Center(
                    child: TextButton(
                      onPressed: () {
                        ref
                            .read(chartDateRangeProvider.notifier)
                            .setChartDate(data);
                        context.pop();
                      },
                      child: Text(
                        DateFormater.formatChartFilter(data),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _monthPickerDateList() {
    final now = DateTime.now();
    List<DateTime> monthPickerDateList = [];

    for (int year = now.year; year >= 2025; year--) {
      if (year == now.year) {
        monthPickerDateList.addAll(_createMonthList(year, now.month));
      } else {
        monthPickerDateList.addAll(_createMonthList(year, 12));
      }
    }

    return monthPickerDateList;
  }

  List<DateTime> _createMonthList(int year, int maxMonth) {
    List<DateTime> monthList = [];

    for (int month = maxMonth; month >= 1; month--) {
      monthList.add(DateTime(year, month));
    }

    return monthList;
  }
}
