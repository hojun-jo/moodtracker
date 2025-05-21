import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/interface/mood_datasource.dart';
import 'package:moodtracker/core/datasources/implement/mood_local_datasource_impl.dart';
import 'package:moodtracker/core/datasources/implement/theme_local_datasource_impl.dart';
import 'package:moodtracker/core/repositories/implement/mood_repository_impl.dart';
import 'package:moodtracker/core/repositories/implement/theme_repository_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/interface/mood_repository.dart';
import 'package:moodtracker/core/repositories/interface/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// theme

final themeLocalDatasource = Provider.autoDispose(
  (ref) => ThemeLocalDatasourceImpl(asyncPref: SharedPreferencesAsync()),
);

final themeRepository =
    AsyncNotifierProvider.autoDispose<ThemeRepository, AppThemeType>(
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
