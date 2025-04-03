import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/infra/datasources/mood_local_datasource_impl.dart';
import 'package:moodtracker/core/infra/datasources/theme_local_datasource_impl.dart';
import 'package:moodtracker/core/infra/repositories/mood_repository_impl.dart';
import 'package:moodtracker/core/infra/repositories/theme_repository_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:path_provider/path_provider.dart';

// theme

final themeLocalDatasource = Provider.autoDispose(
  (ref) => ThemeLocalDatasourceImpl(),
);

final themeRepository =
    AsyncNotifierProvider.autoDispose<ThemeRepositoryImpl, AppThemeType>(
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

final moodRepository = Provider<MoodRepository>((ref) {
  return MoodRepositoryImpl(moodDatasource: ref.read(moodLocalDatasource));
});
