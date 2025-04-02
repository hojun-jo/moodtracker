import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/infra/datasources/mood_local_datasource_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final Future<MoodDatasource> moodDatasource;

  MoodRepositoryImpl({required this.moodDatasource});

  @override
  Future<void> addMood(MoodModel mood) async {
    final datasource = await moodDatasource;

    await datasource.addMood(mood);
  }

  @override
  Future<List<MoodModel>> getMoods() async {
    final datasource = await moodDatasource;

    return await datasource.getMoods();
  }

  @override
  Future<void> deleteMood(MoodModel mood) async {
    final datasource = await moodDatasource;

    await datasource.deleteMood(mood);
  }
}

final moodRepository = Provider<MoodRepository>((ref) {
  return MoodRepositoryImpl(moodDatasource: ref.read(moodLocalDatasource));
});
