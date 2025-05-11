import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

class MoodLocalDatasourceImpl implements MoodDatasource {
  final Isar isar;

  MoodLocalDatasourceImpl({required this.isar});

  @override
  Future<void> addMood(
    MoodType mood,
    String description,
  ) async {
    try {
      await isar.writeTxn<void>(() async {
        await isar.moodModels.put(MoodModel(
          id: Isar.autoIncrement,
          moodType: mood,
          description: description,
          createdAt: DateTime.now(),
        ));
      });
    } catch (e) {
      throw Exception('Failed to add mood: $e');
    }
  }

  @override
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange}) {
    if (dateRange != null) {
      final startDate = dateRange.start;
      final endDate = dateRange.end;
      return isar.moodModels
          .filter()
          .createdAtBetween(
            DateTime(startDate.year, startDate.month, startDate.day),
            DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59),
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
