import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/datasources/interfaces/mood_datasource.dart';
import 'package:moodtracker/core/datasources/implements/theme_local_datasource_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/interfaces/mood_repository.dart';
import 'package:moodtracker/core/utils/file_loader.dart';
import 'package:moodtracker/features/chart/repositories/chart_date_range_repository.dart';
import 'package:moodtracker/features/chart/repositories/chart_state_repository.dart';
import 'package:moodtracker/features/chart/repositories/sample_chart_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// theme

class MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync {}

class MockThemeLocalDatasource extends Mock
    implements ThemeLocalDatasourceImpl {}

// mood

class MockIsar extends Mock implements Isar {}

class MockMoodLocalDatasource extends Mock implements MoodDatasource {}

class MockMoodRepository extends MoodRepository with Mock {
  @override
  Stream<List<MoodModel>> build(DateTimeRange? dateRange) {
    return watchMoods(dateRange: dateRange);
  }
}

// chart

class MockSampleChartRepository extends Mock implements SampleChartRepository {}

class MockChartStateRepository extends Mock implements ChartStateRepository {}

class MockChartDateRangeRepository extends Mock
    implements ChartDateRangeRepository {
  final _state = ValueNotifier<DateTimeRange>(
    DateTimeRange(
      start: DateTime(2024, 1, 1),
      end: DateTime(2024, 1, 31),
    ),
  );

  @override
  DateTimeRange build() => _state.value;

  @override
  DateTimeRange get state => _state.value;

  @override
  void setChartDate(DateTime date) {
    _state.value = DateTimeRange(
      start: DateTime(date.year, date.month),
      end: DateTime(date.year, date.month + 1, 0),
    );
  }
}

// utils

class MockFileLoader implements FileLoader {
  String? mockData;
  Exception? throwError;

  MockFileLoader({this.mockData, this.throwError});

  @override
  Future<String> loadString(String path) async {
    if (throwError != null) {
      throw throwError!;
    }
    if (mockData == null) {
      throw Exception('File not found');
    }
    return mockData!;
  }
}
