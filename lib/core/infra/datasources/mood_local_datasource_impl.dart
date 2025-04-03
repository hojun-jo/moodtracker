import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';

class MoodLocalDatasourceImpl implements MoodDatasource {
  final Isar isar;

  MoodLocalDatasourceImpl({required this.isar});

  @override
  Future<void> addMood(MoodModel mood) async {
    await isar.writeTxn(() async {
      await isar.moodModels.put(mood);
    });
  }

  @override
  Stream<List<MoodModel>> watchMoods() {
    return isar.moodModels
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  @override
  Future<void> deleteMood(MoodModel mood) async {
    await isar.writeTxn(() async {
      await isar.moodModels.delete(mood.id);
    });
  }
}
