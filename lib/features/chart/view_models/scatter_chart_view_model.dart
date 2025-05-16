import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/chart/models/scatter_model.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

class ScatterChartViewModel
    extends AutoDisposeNotifier<AsyncValue<List<ScatterModel>>> {
  @override
  AsyncValue<List<ScatterModel>> build() {
    final dateRange = ref.watch(chartDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));
    final chartState = ref.read(chartStateProvider);

    return moods.when(
      data: (realData) {
        if (realData.isEmpty) {
          chartState.setIsChartSample(true);

          return ref.watch(sampleChartProvider).when(
                data: (sample) {
                  return AsyncValue.data(_createScatterModels(sample));
                },
                error: (error, stackTrace) => throw error,
                loading: () => const AsyncValue.loading(),
              );
        }

        chartState.setIsChartSample(false);

        return AsyncValue.data(_createScatterModels(realData));
      },
      error: (error, stackTrace) => throw error,
      loading: () => const AsyncValue.loading(),
    );
  }

  List<ScatterModel> _createScatterModels(List<MoodModel> data) {
    final List<ScatterModel> scatterModels = [];

    for (int hour = 0; hour < 24; hour++) {
      final moods = data.where((mood) => mood.createdAt.hour == hour);

      for (final type in MoodType.values) {
        final count =
            moods.where((mood) => mood.moodCategory.type == type).length;

        if (count > 0) {
          scatterModels.add(ScatterModel(hour: hour, type: type, count: count));
        }
      }
    }

    return scatterModels;
  }
}
