import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';

class MoodRepositoryImpl
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, DateTimeRange?>
    implements MoodRepository {
  late final Future<MoodDatasource> moodDatasource;

  @override
  Stream<List<MoodModel>> build(DateTimeRange? dateRange) {
    moodDatasource = ref.read(moodLocalDatasource);

    return watchMoods(dateRange: dateRange);
  }

  @override
<<<<<<< HEAD
  Future<void> addMood(
    MoodCategory mood,
    String description,
  ) async {
    final datasource = await moodDatasource;

    await datasource.addMood(mood, description);
  }

  @override
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange}) async* {
    final datasource = await moodDatasource;

    yield* datasource.watchMoods(dateRange: dateRange);
=======
  Stream<List<MoodModel>> watchMoods({DateTime? date}) async* {
    final datasource = await moodDatasource;

    yield* datasource.watchMoods(date: date);
>>>>>>> origin/main
  }
}
