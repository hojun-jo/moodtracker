import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

abstract class MoodDatasource {
  Future<void> addMood(MoodType mood, String description);
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange});
}
