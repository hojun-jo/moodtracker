import 'package:moodtracker/core/models/mood/mood_model.dart';

abstract class MoodDatasource {
  Future<void> addMood(MoodModel mood);
  Future<List<MoodModel>> getMoods();
  Future<void> deleteMood(MoodModel mood);
}
