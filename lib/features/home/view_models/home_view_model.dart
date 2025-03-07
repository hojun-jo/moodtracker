import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/utils/date_formater.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';
import 'package:moodtracker/features/home/repos/home_repository.dart';

class HomeViewModel extends StreamNotifier<List<MoodModel>> {
  late final HomeRepository _repository;

  @override
  Stream<List<MoodModel>> build() {
    _repository = ref.read(homeRepo);
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

  String formatDate(DateTime date) {
    return DateFormater.format(date);
  }
}

final homeProvider = StreamNotifierProvider<HomeViewModel, List<MoodModel>>(
  () => HomeViewModel(),
);
