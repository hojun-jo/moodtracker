import 'package:moodtracker/core/datasources/mood_datasource.dart';
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
  Stream<List<MoodModel>> watchMoods({DateTime? date}) async* {
    final datasource = await moodDatasource;

    yield* datasource.watchMoods(date: date);
  }
}
