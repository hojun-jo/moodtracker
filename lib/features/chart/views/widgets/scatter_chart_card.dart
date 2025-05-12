import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/chart/constants/chart_constants.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

class ScatterChartCard extends ConsumerWidget {
  const ScatterChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scatterModels = ref.watch(scatterChartProvider);

    return scatterModels.when(
      data: (data) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(chartCardPadding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -10,
                  left: -24,
                  child: Column(
                    spacing: 11.5,
                    children: [
                      ...MoodType.values.reversed.map((type) {
                        return Image.asset(
                          type.assetName,
                          width: 20,
                        );
                      }),
                    ],
                  ),
                ),
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
                              color: mood.type.color.withAlpha(200),
                            ),
                          );
                        }),
                      ],
                      minX: 0,
                      maxX: 24,
                      minY: 0,
                      maxY: MoodType.values.length.toDouble(),
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
                      ),
                    ),
                  ),
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
