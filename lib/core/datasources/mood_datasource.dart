import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';

abstract class MoodDatasource {
  Future<void> addMood(MoodModel mood);
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange});
}
