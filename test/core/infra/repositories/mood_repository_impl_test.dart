import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

import '../../../mock.dart';

void main() {
  late MockMoodLocalDatasource mockDatasource;
  late Future<MoodDatasource> futureDatasource;
  late ProviderContainer container;

  setUp(() {
    mockDatasource = MockMoodLocalDatasource();
    futureDatasource = Future.value(mockDatasource);
    container = ProviderContainer(
      overrides: [
        moodLocalDatasource.overrideWithValue(futureDatasource),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('addMood', () {
    test('should successfully add mood', () async {
      // given
      const moodType = MoodCategory.happy;
      const description = "happy";
      when(() => mockDatasource.addMood(moodType, description))
          .thenAnswer((_) async {});

      // when
      await container
          .read(moodRepository(null).notifier)
          .addMood(moodType, description);

      // then
      verify(() => mockDatasource.addMood(moodType, description)).called(1);
    });

    test('should handle error when adding mood fails', () async {
      // given
      const moodType = MoodCategory.happy;
      const description = "happy";
      when(() => mockDatasource.addMood(moodType, description))
          .thenThrow(Exception('Failed to add mood'));

      // when
      // then
      expect(
          () => container
              .read(moodRepository(null).notifier)
              .addMood(moodType, description),
          throwsException);
    });
  });

  group('watchMoods', () {
    test('should stream moods without date filter', () async {
      // given
      final moods = [
        MoodModel(
          id: 1,
          moodCategory: MoodCategory.happy,
          description: "happy",
          createdAt: DateTime.now(),
        ),
        MoodModel(
          id: 2,
          moodCategory: MoodCategory.angry,
          description: "bad",
          createdAt: DateTime.now(),
        ),
      ];
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.value(moods));

      // when
      final stream = container.read(moodRepository(null).notifier).watchMoods();

      // then
      expect(stream, emits(moods));
    });

    test('should stream moods with single day date range', () async {
      // given
      final date = DateTime(2024, 3, 20);
      final dateRange = DateTimeRange(
        start: date,
        end: date,
      );
      final moods = [
        MoodModel(
          id: 1,
          moodCategory: MoodCategory.happy,
          description: "happy",
          createdAt: date,
        ),
      ];
      when(() => mockDatasource.watchMoods(dateRange: dateRange))
          .thenAnswer((_) => Stream.value(moods));

      // when
      final stream = container
          .read(moodRepository(null).notifier)
          .watchMoods(dateRange: dateRange);

      // then
      expect(stream, emits(moods));
    });

    test('should stream moods with multi-day date range', () async {
      // given
      final startDate = DateTime(2024, 3, 20);
      final endDate = DateTime(2024, 3, 22);
      final dateRange = DateTimeRange(
        start: startDate,
        end: endDate,
      );
      final moods = [
        MoodModel(
          id: 1,
          moodCategory: MoodCategory.happy,
          description: "happy",
          createdAt: DateTime(2024, 3, 20),
        ),
        MoodModel(
          id: 2,
          moodCategory: MoodCategory.sad,
          description: "sad",
          createdAt: DateTime(2024, 3, 21),
        ),
        MoodModel(
          id: 3,
          moodCategory: MoodCategory.angry,
          description: "angry",
          createdAt: DateTime(2024, 3, 22),
        ),
      ];
      when(() => mockDatasource.watchMoods(dateRange: dateRange))
          .thenAnswer((_) => Stream.value(moods));

      // when
      final stream = container
          .read(moodRepository(null).notifier)
          .watchMoods(dateRange: dateRange);

      // then
      expect(stream, emits(moods));
    });

    test('should handle empty mood list', () async {
      // given
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.value([]));

      // when
      final stream = container.read(moodRepository(null).notifier).watchMoods();

      // then
      expect(stream, emits([]));
    });

    test('should handle error in mood stream', () async {
      // given
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.error(Exception('Stream error')));

      // when
      final stream = container.read(moodRepository(null).notifier).watchMoods();

      // then
      expect(stream, emitsError(isA<Exception>()));
    });
  });
}
