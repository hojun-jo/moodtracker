import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

class MoodLocalDatasourceImpl implements MoodDatasource {
  final Isar isar;

  MoodLocalDatasourceImpl({required this.isar});

  @override
<<<<<<< HEAD
  Future<void> addMood(
    MoodCategory mood,
    String description,
  ) async {
    try {
      await isar.writeTxn<void>(() async {
        await isar.moodModels.put(MoodModel(
          id: Isar.autoIncrement,
          moodCategory: mood,
          description: description,
          createdAt: DateTime.now(),
        ));
=======
  Future<void> addMood(MoodModel mood) async {
    try {
      await isar.writeTxn<void>(() async {
        await isar.moodModels.put(mood);
>>>>>>> origin/main
      });
    } catch (e) {
      throw Exception('Failed to add mood: $e');
    }
  }

  @override
<<<<<<< HEAD
  Stream<List<MoodModel>> watchMoods({DateTimeRange? dateRange}) {
    if (dateRange != null) {
      final startDate = dateRange.start;
      final endDate = dateRange.end;
      return isar.moodModels
          .filter()
          .createdAtBetween(
            DateTime(startDate.year, startDate.month, startDate.day),
            DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59),
=======
  Stream<List<MoodModel>> watchMoods({DateTime? date}) {
    if (date != null) {
      return isar.moodModels
          .filter()
          .createdAtBetween(
            DateTime(date.year, date.month, date.day),
            DateTime(date.year, date.month, date.day, 23, 59, 59),
>>>>>>> origin/main
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
