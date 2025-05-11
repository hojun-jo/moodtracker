import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/home/providers/home_date_range_provider.dart';

class HomeViewModel extends AutoDisposeNotifier<AsyncValue<List<MoodModel>>> {
  @override
  AsyncValue<List<MoodModel>> build() {
    final dateRange = ref.watch(homeDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));

    return moods;
  }

  String formatDate(DateTime date) {
    return DateFormater.formatMoodCard(date);
  }
}

final homeProvider =
    NotifierProvider.autoDispose<HomeViewModel, AsyncValue<List<MoodModel>>>(
  () => HomeViewModel(),
);
