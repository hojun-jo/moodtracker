import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';

class MoodLocalDatasourceImpl implements MoodDatasource {
  final Isar isar;

  MoodLocalDatasourceImpl({required this.isar});

  @override
  Future<void> addMood(MoodModel mood) async {
    try {
      await isar.writeTxn<void>(() async {
        await isar.moodModels.put(mood);
      });
    } catch (e) {
      throw Exception('Failed to add mood: $e');
    }
  }

  @override
  Stream<List<MoodModel>> watchMoods({DateTime? date}) {
    if (date != null) {
      return isar.moodModels
          .filter()
          .createdAtBetween(
            DateTime(date.year, date.month, date.day),
            DateTime(date.year, date.month, date.day, 23, 59, 59),
          )
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
    }

    return isar.moodModels
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }
}
