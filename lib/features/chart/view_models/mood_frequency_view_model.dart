import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/chart/models/mood_type_count.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

class MoodFrequencyViewModel
    extends AutoDisposeNotifier<AsyncValue<List<MoodTypeCount>>> {
  @override
  AsyncValue<List<MoodTypeCount>> build() {
    final dateRange = ref.watch(chartDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));

    return moods.when(
      data: (data) {
        return AsyncValue.data(
          MoodType.values.map((moodType) {
            final count =
                data.where((mood) => mood.moodType == moodType).length;
            return MoodTypeCount(type: moodType, count: count);
          }).toList()
            ..sort((a, b) => b.count.compareTo(a.count)),
        );
      },
      error: (error, stackTrace) => throw error,
      loading: () => const AsyncValue.loading(),
    );
  }
}
