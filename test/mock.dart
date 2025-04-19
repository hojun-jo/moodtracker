import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/infra/datasources/theme_local_datasource_impl.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync {}

class MockThemeLocalDatasource extends Mock
    implements ThemeLocalDatasourceImpl {}

class MockIsar extends Mock implements Isar {}

class MockMoodLocalDatasource extends Mock implements MoodDatasource {}

class MockMoodRepository extends Mock implements MoodRepository {}
