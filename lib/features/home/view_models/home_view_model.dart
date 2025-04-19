import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';
import 'package:moodtracker/core/utils/date_formater.dart';

class HomeViewModel
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, DateTime?> {
  late final MoodRepository _moodRepository;

  @override
  Stream<List<MoodModel>> build(DateTime? date) {
    _moodRepository = ref.read(moodRepository);

    return _moodRepository.watchMoods(date: date);
  }

  String formatDate(DateTime date) {
    return DateFormater.formatMoodCard(date);
  }
}

final homeProvider = StreamNotifierProvider.autoDispose
    .family<HomeViewModel, List<MoodModel>, DateTime?>(
  () => HomeViewModel(),
);
