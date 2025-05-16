import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/home/provider/provider.dart';

<<<<<<< HEAD
class HomeViewModel extends AutoDisposeNotifier<AsyncValue<List<MoodModel>>> {
  @override
  AsyncValue<List<MoodModel>> build() {
    final dateRange = ref.watch(homeDateRangeProvider);
    final moods = ref.watch(moodRepository(dateRange));

    return moods;
=======
class HomeViewModel
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, DateTime?> {
  late final MoodRepository _moodRepository;

  @override
  Stream<List<MoodModel>> build(DateTime? date) {
    _moodRepository = ref.read(moodRepository);

    return _moodRepository.watchMoods(date: date);
>>>>>>> origin/main
  }

  String formatDate(DateTime date) {
    return DateFormater.formatMoodCard(date);
  }
}
<<<<<<< HEAD
=======

final homeProvider = StreamNotifierProvider.autoDispose
    .family<HomeViewModel, List<MoodModel>, DateTime?>(
  () => HomeViewModel(),
);
>>>>>>> origin/main
