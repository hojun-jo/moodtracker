import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/chart/constants/chart_constants.dart';
import 'package:moodtracker/features/chart/providers/provider.dart';

class PieChartCard extends ConsumerWidget {
  const PieChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pieChartSectionDataList = ref.watch(pieChartProvider);

    return pieChartSectionDataList.when(
      data: (data) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(chartCardPadding),
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: data,
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => CenterText(text: error.toString()),
      loading: () => const CenterProgressIndicator(),
    );
  }
}
