import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:path_provider/path_provider.dart';

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
  Future<List<MoodModel>> getMoods() async {
    return await isar.moodModels.where().sortByCreatedAtDesc().findAll();
  }

  @override
  Stream<List<MoodModel>> watchMoods() {
    return isar.moodModels.where().sortByCreatedAtDesc().watch();
  }

  @override
  Future<void> deleteMood(MoodModel mood) async {
    await isar.writeTxn(() async {
      await isar.moodModels.delete(mood.id);
    });
  }
}

final isarProvider = Provider<Future<Isar>>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [MoodModelSchema],
    directory: dir.path,
  );

  return isar;
});

final moodLocalDatasource = Provider<Future<MoodDatasource>>((ref) async {
  return MoodLocalDatasourceImpl(isar: await ref.read(isarProvider));
});
