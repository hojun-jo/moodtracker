import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/interfaces/mood_datasource.dart';
import 'package:moodtracker/core/datasources/implements/mood_local_datasource_impl.dart';
import 'package:moodtracker/core/datasources/implements/theme_local_datasource_impl.dart';
import 'package:moodtracker/core/repositories/implements/mood_repository_impl.dart';
import 'package:moodtracker/core/repositories/implements/theme_repository_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/interfaces/mood_repository.dart';
import 'package:moodtracker/core/repositories/interfaces/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// theme

final themeLocalDatasource = Provider.autoDispose(
  (ref) => ThemeLocalDatasourceImpl(asyncPref: SharedPreferencesAsync()),
);

final themeRepository =
    AsyncNotifierProvider.autoDispose<ThemeRepository, AppThemeData>(
  () => ThemeRepositoryImpl(),
);

// mood

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

final moodRepository = StreamNotifierProvider.autoDispose
    .family<MoodRepository, List<MoodModel>, DateTimeRange?>(() {
  return MoodRepositoryImpl();
});
