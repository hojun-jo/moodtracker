import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';

class HomeViewModel extends AutoDisposeStreamNotifier<List<MoodModel>> {
  @override
  Stream<List<MoodModel>> build() {
    return Stream.value([]);
  }

  Future<void> deleteMood(MoodModel mood) async {}

  String formatDate(DateTime date) {
    return DateFormater.format(date);
  }
}

final homeProvider =
    StreamNotifierProvider.autoDispose<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);
