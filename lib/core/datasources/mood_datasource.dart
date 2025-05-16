import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

abstract class MoodDatasource {
<<<<<<< HEAD
  Future<void> addMood(MoodCategory mood, String description);
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange});
=======
  Future<void> addMood(MoodModel mood);
  Stream<List<MoodModel>> watchMoods({DateTime? date});
>>>>>>> origin/main
}
