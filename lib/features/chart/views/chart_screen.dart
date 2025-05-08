import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/chart/views/widgets/mood_count_item.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';

class ChartScreen extends ConsumerStatefulWidget {
  const ChartScreen({super.key});

  @override
  ConsumerState<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends ConsumerState<ChartScreen> {
  final moodTypeOrder = ValueNotifier<List<({MoodType type, int count})>>([]);

  @override
  Widget build(BuildContext context) {
    final moodStream = ref.watch(homeProvider);

    return moodStream.when(
      data: (data) {
        final length = data.length;

        moodTypeOrder.value = MoodType.values.map((moodType) {
          final count = data.where((mood) => mood.moodType == moodType).length;
          return (type: moodType, count: count);
        }).toList()
          ..sort((a, b) => b.count.compareTo(a.count));

        final List<({int hour, MoodType type, int count})> hourMoodCount = [];

        for (int hour = 0; hour < 24; hour++) {
          final moods = data.where((mood) => mood.createdAt.hour == hour);

          for (final type in MoodType.values) {
            final count = moods.where((mood) => mood.moodType == type).length;

            if (count > 0) {
              hourMoodCount.add((hour: hour, type: type, count: count));
            }
          }
        }

        return SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          ...MoodType.values.map(
                            (moodType) {
                              final moodTypeCount = data
                                  .where((mood) => mood.moodType == moodType)
                                  .length;
                              final moodTypeRatio =
                                  moodTypeCount / length * 100;

                              return PieChartSectionData(
                                color: moodType.color,
                                radius: 100,
                                value: moodTypeRatio,
                                title: "${moodTypeRatio.toInt()}%",
                                badgeWidget: Image.asset(
                                  moodType.assetName,
                                  width: 35,
                                ),
                                badgePositionPercentageOffset: 1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: moodTypeOrder,
                builder: (context, value, child) {
                  return Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...moodTypeOrder.value.map((moodTypeCount) {
                            return MoodCountItem(
                              moodAssetName: moodTypeCount.type.assetName,
                              moodCount: moodTypeCount.count,
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -10,
                        left: -24,
                        child: Column(
                          spacing: 11.2,
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
                              ...hourMoodCount.map((mood) {
                                return ScatterSpot(
                                  mood.hour.toDouble(),
                                  mood.type.scatterY,
                                  dotPainter: FlDotCirclePainter(
                                    radius:
                                        (40 * mood.count) / (mood.count + 9),
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
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return CenterText(text: error.toString());
      },
      loading: () {
        return const CenterProgressIndicator();
      },
    );
  }
}
