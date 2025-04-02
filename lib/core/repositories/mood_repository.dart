import 'package:moodtracker/core/models/mood/mood_model.dart';

abstract class MoodRepository {
  Future<void> addMood(MoodModel mood);
  Stream<List<MoodModel>> watchMoods();
  Future<void> deleteMood(MoodModel mood);
}
