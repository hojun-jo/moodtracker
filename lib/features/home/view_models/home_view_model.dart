import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';
import 'package:moodtracker/core/utils/date_formater.dart';

class HomeViewModel extends AutoDisposeStreamNotifier<List<MoodModel>> {
  late final MoodRepository _moodRepository;

  @override
  Stream<List<MoodModel>> build() {
    _moodRepository = ref.read(moodRepository);

    return _moodRepository.watchMoods();
  }

  Future<void> deleteMood(MoodModel mood) async {
    await _moodRepository.deleteMood(mood);
  }

  String formatDate(DateTime date) {
    return DateFormater.format(date);
  }
}

final homeProvider =
    StreamNotifierProvider.autoDispose<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);
