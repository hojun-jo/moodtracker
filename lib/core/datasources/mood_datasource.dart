import 'package:moodtracker/core/models/mood/mood_model.dart';

abstract class MoodDatasource {
  Future<void> addMood(MoodModel mood);
  Future<List<MoodModel>> getMoods();
  Stream<List<MoodModel>> watchMoods();
  Future<void> deleteMood(MoodModel mood);
}
