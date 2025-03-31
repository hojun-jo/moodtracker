import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';
import 'package:moodtracker/core/repos/mood_repository.dart';

class HomeViewModel extends AutoDisposeStreamNotifier<List<MoodModel>> {
  late final MoodRepository _repository;

  @override
  Stream<List<MoodModel>> build() {
    _repository = ref.read(moodRepo);
    final user = ref.read(authRepo).user!;

    return _repository.fetchMoods(user.uid).map((snapshot) {
      List<MoodModel> models = [];

      for (final doc in snapshot.docs) {
        final json = doc.data();
        final model = MoodModel.fromJson(json);

        models.add(model);
      }

      return models;
    });
  }

  Future<void> deleteMood(MoodModel mood) async {
    await _repository.deleteMood(uid: mood.uid, id: mood.id);
  }

  String formatDate(DateTime date) {
    return DateFormater.format(date);
  }
}

final homeProvider =
    StreamNotifierProvider.autoDispose<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);
