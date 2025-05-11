import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/home/providers/home_date_range_provider.dart';

class HomeViewModel extends AutoDisposeStreamNotifier<List<MoodModel>> {
  @override
  Stream<List<MoodModel>> build() {
    final dateRange = ref.watch(homeDateRangeProvider);
    final repository = ref.read(moodRepository(dateRange).notifier);

    return repository.watchMoods(dateRange: dateRange);
  }

  String formatDate(DateTime date) {
    return DateFormater.formatMoodCard(date);
  }
}

final homeProvider =
    StreamNotifierProvider.autoDispose<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);
