import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

class PieChartViewModel
    extends AutoDisposeNotifier<AsyncValue<List<PieChartSectionData>>> {
  @override
  AsyncValue<List<PieChartSectionData>> build() {
    final dateRange = ref.watch(chartDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));

    return moods.when(
      data: (data) {
        final length = data.length;

        return AsyncValue.data(
          MoodType.values.map((moodType) {
            final moodTypeCount =
                data.where((mood) => mood.moodType == moodType).length;
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
          }).toList(),
        );
      },
      error: (error, stackTrace) => throw error,
      loading: () => const AsyncValue.loading(),
    );
  }
}
