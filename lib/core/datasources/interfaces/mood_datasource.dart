import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

abstract interface class MoodDatasource {
  Future<void> addMood(MoodCategory mood, String description);
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange});
}
