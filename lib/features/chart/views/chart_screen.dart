import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';
import 'package:moodtracker/features/chart/views/widgets/month_picker_dialog.dart';
import 'package:moodtracker/features/chart/views/widgets/mood_frequency_card.dart';
import 'package:moodtracker/features/chart/views/widgets/pie_chart_card.dart';
import 'package:moodtracker/features/chart/views/widgets/scatter_chart_card.dart';

class ChartScreen extends ConsumerStatefulWidget {
  const ChartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartScreenState();
}

class _ChartScreenState extends ConsumerState<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    final isChartSample = ref.watch(chartStateProvider).isChartSample;
    final filterDate = ref.watch(chartDateRangeProvider).start;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          GestureDetector(
            onTap: _showMonthPicker,
            child: Text(
              "< ${DateFormater.formatChartFilter(filterDate)} >",
              style: textTheme.bodyLarge,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isChartSample,
            builder: (context, value, child) {
              if (value) {
                return Text(
                  "🚧  Sample Data  🚧",
                  style: textTheme.bodyLarge,
                );
              }
              return Container();
            },
          ),
          const PieChartCard(),
          const MoodFrequencyCard(),
          const ScatterChartCard(),
        ],
      ),
    );
  }

  void _showMonthPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return const MonthPickerDialog();
      },
    );
  }
}
