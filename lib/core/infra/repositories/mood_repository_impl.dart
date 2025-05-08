import 'package:flutter/material.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';

// TODO: AutoDisposeStreamNotifier로 만들어서 chart view model에 제공 -> chart view model에서 chart screen이 수행 중인 로직 수행
class MoodRepositoryImpl implements MoodRepository {
  final Future<MoodDatasource> moodDatasource;

  MoodRepositoryImpl({required this.moodDatasource});

  @override
  Future<void> addMood(MoodModel mood) async {
    final datasource = await moodDatasource;

    await datasource.addMood(mood);
  }

  @override
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange}) async* {
    final datasource = await moodDatasource;

    yield* datasource.watchMoods(dateRange: dateRange);
  }
}
