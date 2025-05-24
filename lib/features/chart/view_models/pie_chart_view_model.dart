import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/features/chart/providers/provider.dart';

class PieChartViewModel
    extends AutoDisposeNotifier<AsyncValue<List<PieChartSectionData>>> {
  @override
  AsyncValue<List<PieChartSectionData>> build() {
    final dateRange = ref.watch(chartDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));
    final chartState = ref.read(chartStateProvider);

    return moods.when(
      data: (realData) {
        if (realData.isEmpty) {
          chartState.setIsChartSample(true);

          return ref.watch(sampleChartProvider).when(
                data: (sample) {
                  return AsyncValue.data(_createPieChartDataList(sample));
                },
                error: (error, stackTrace) => throw error,
                loading: () => const AsyncValue.loading(),
              );
        }

        chartState.setIsChartSample(false);

        return AsyncValue.data(_createPieChartDataList(realData));
      },
      error: (error, stackTrace) => throw error,
      loading: () => const AsyncValue.loading(),
    );
  }

  List<PieChartSectionData> _createPieChartDataList(List<MoodModel> data) {
    final length = data.length;

    return MoodCategory.values.map((moodType) {
      final moodTypeCount =
          data.where((mood) => mood.moodCategory == moodType).length;
      final moodTypeRatio = moodTypeCount / length * 100;

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
    }).toList();
  }
}
