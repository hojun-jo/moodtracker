import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

abstract class MoodRepository
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, DateTimeRange?> {
  Future<void> addMood(MoodCategory mood, String description);
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange});
}
