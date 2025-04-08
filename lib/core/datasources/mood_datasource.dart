import 'package:moodtracker/core/models/mood/mood_model.dart';

abstract class MoodDatasource {
  Future<void> addMood(MoodModel mood);
  Stream<List<MoodModel>> watchMoods({DateTime? date});
  Future<void> deleteMood(MoodModel mood);
}
