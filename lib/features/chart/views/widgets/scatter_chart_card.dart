import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/chart/constants/chart_constants.dart';
import 'package:moodtracker/features/chart/providers/provider.dart';
import 'package:moodtracker/features/chart/views/widgets/scatter_chart_legend.dart';

class ScatterChartCard extends ConsumerWidget {
  const ScatterChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final scatterModels = ref.watch(scatterChartProvider);

    return scatterModels.when(
      data: (data) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(chartCardPadding),
            child: Column(
              spacing: 20,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        ...data.map((mood) {
                          return ScatterSpot(
                            mood.hour.toDouble(),
                            mood.type.scatterY,
                            dotPainter: FlDotCirclePainter(
                              radius: (40 * mood.count) / (mood.count + 9),
                              color: mood.type.color.withAlpha(220),
                            ),
                          );
                        }),
                      ],
                      minX: 0,
                      maxX: 24,
                      minY: 0,
                      maxY: MoodType.values.length.toDouble() + 0.5,
                      titlesData: const FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            interval: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Column(
                  spacing: 8,
                  children: [
                    ScatterChartLegend(moodType: MoodType.positive),
                    ScatterChartLegend(moodType: MoodType.neutrality),
                    ScatterChartLegend(moodType: MoodType.negative),
                  ],
                ),
                Text(
                  "Scatter Chart Explain".tr(),
                  style: textTheme.bodySmall!.copyWith(color: AppColor.black),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => CenterText(text: error.toString()),
      loading: () => const CenterProgressIndicator(),
    );
  }
}
