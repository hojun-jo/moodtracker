import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/features/chart/models/mood_category_count.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

class MoodFrequencyViewModel
    extends AutoDisposeNotifier<AsyncValue<List<MoodCategoryCount>>> {
  @override
  AsyncValue<List<MoodCategoryCount>> build() {
    final dateRange = ref.watch(chartDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));
    final chartState = ref.read(chartStateProvider);

    return moods.when(
      data: (realData) {
        if (realData.isEmpty) {
          chartState.setIsChartSample(true);

          return ref.watch(sampleChartProvider).when(
                data: (sample) {
                  return AsyncValue.data(_createMoodTypeCountList(sample));
                },
                error: (error, stackTrace) => throw error,
                loading: () => const AsyncValue.loading(),
              );
        }

        chartState.setIsChartSample(false);

        return AsyncValue.data(_createMoodTypeCountList(realData));
      },
      error: (error, stackTrace) => throw error,
      loading: () => const AsyncValue.loading(),
    );
  }

  List<MoodCategoryCount> _createMoodTypeCountList(List<MoodModel> data) {
    return MoodCategory.values.map((moodType) {
      final count = data.where((mood) => mood.moodCategory == moodType).length;
      return MoodCategoryCount(category: moodType, count: count);
    }).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
  }
}
