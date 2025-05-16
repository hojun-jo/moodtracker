<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
>>>>>>> origin/main
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
<<<<<<< HEAD
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/features/home/provider/provider.dart';
=======
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';
>>>>>>> origin/main

import '../../mock.dart';

void main() {
<<<<<<< HEAD
  final date = DateTime(2024, 3, 20);
  final dateRange = DateTimeRange(
    start: date,
    end: date,
  );
  late MockMoodRepository mockMoodRepository;
  late ProviderContainer container;

=======
  late MockMoodRepository mockMoodRepository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(Stream.value([
      MoodModel(
        id: 0,
        moodType: MoodType.happy,
        description: '',
        createdAt: DateTime(0),
      )
    ]));
    registerFallbackValue(DateTime(0));
  });

>>>>>>> origin/main
  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
<<<<<<< HEAD
        moodRepository.overrideWith(() => mockMoodRepository),
        homeDateRangeProvider.overrideWith((ref) => dateRange),
=======
        moodRepository.overrideWith((ref) => mockMoodRepository),
>>>>>>> origin/main
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should return empty list when no moods exist', () async {
    // given
<<<<<<< HEAD
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value([]));

    // when
    // then
    container.read(homeProvider).when(
          data: (data) {
            expect(data, isEmpty);
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: dateRange)).called(1);
=======
    final date = DateTime(2024, 3, 20);
    when(() => mockMoodRepository.watchMoods(date: date))
        .thenAnswer((_) => Stream.value([]));

    // when
    final futureResult = container.read(homeProvider(date).future);

    // then
    await expectLater(futureResult, completion(isEmpty));
    verify(() => mockMoodRepository.watchMoods(date: date)).called(1);
>>>>>>> origin/main
  });

  test('should return list of moods when they exist', () async {
    // given
<<<<<<< HEAD
    final mockMoods = [
      MoodModel(
        id: 1,
        moodCategory: MoodCategory.happy,
        description: 'Great day!',
        createdAt: dateRange.start,
      ),
      MoodModel(
        id: 2,
        moodCategory: MoodCategory.angry,
        description: 'Not so good day',
        createdAt: dateRange.start,
      ),
    ];
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value(mockMoods));

    // when
    // then
    container.read(homeProvider).when(
          data: (data) {
            expect(data.length, 2);
            expect(data[0].moodCategory, equals(MoodCategory.happy));
            expect(data[1].moodCategory, equals(MoodCategory.angry));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: dateRange)).called(1);
  });

  test('should handle null date range parameter', () async {
=======
    final date = DateTime(2024, 3, 20);
    final mockMoods = [
      MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: 'Great day!',
        createdAt: date,
      ),
      MoodModel(
        id: 2,
        moodType: MoodType.angry,
        description: 'Not so good day',
        createdAt: date,
      ),
    ];
    when(() => mockMoodRepository.watchMoods(date: date))
        .thenAnswer((_) => Stream.value(mockMoods));

    // when
    final futureResult = container.read(homeProvider(date).future);
    final moods = await futureResult;

    // then
    expect(moods, hasLength(2));
    expect(moods[0].moodType, equals(MoodType.happy));
    expect(moods[1].moodType, equals(MoodType.angry));
    verify(() => mockMoodRepository.watchMoods(date: date)).called(1);
  });

  test('should handle null date parameter', () async {
>>>>>>> origin/main
    // given
    final mockMoods = [
      MoodModel(
        id: 1,
<<<<<<< HEAD
        moodCategory: MoodCategory.happy,
=======
        moodType: MoodType.happy,
>>>>>>> origin/main
        description: 'Today is good',
        createdAt: DateTime.now(),
      ),
    ];
<<<<<<< HEAD
    when(() => mockMoodRepository.watchMoods(dateRange: null))
        .thenAnswer((_) => Stream.value(mockMoods));

    // when
    container.updateOverrides([
      moodRepository.overrideWith(() => mockMoodRepository),
      homeDateRangeProvider.overrideWith((ref) => null),
    ]);

    // then
    container.read(homeProvider).when(
          data: (data) {
            expect(data.length, 1);
            expect(data[0].moodCategory, equals(MoodCategory.happy));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: null)).called(1);
=======
    when(() => mockMoodRepository.watchMoods(date: null))
        .thenAnswer((_) => Stream.value(mockMoods));

    // when
    final futureResult = container.read(homeProvider(null).future);
    final moods = await futureResult;

    // then
    expect(moods, hasLength(1));
    expect(moods[0].moodType, equals(MoodType.happy));
    verify(() => mockMoodRepository.watchMoods(date: null)).called(1);
>>>>>>> origin/main
  });

  test('should format date correctly', () {
    // given
<<<<<<< HEAD
    final testDate = date;

    // when
    final viewModel = container.read(homeProvider.notifier);
    final formattedDate = viewModel.formatDate(testDate);
=======
    final date = DateTime(2024, 3, 20);

    // when
    final formattedDate =
        container.read(homeProvider(null).notifier).formatDate(date);
>>>>>>> origin/main

    // then
    expect(formattedDate, equals('Wed, Mar 20'));
  });

<<<<<<< HEAD
  test('should handle stream error', () async {
    // given
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
=======
  test('should handle stream error gracefully', () async {
    // given
    final date = DateTime(2024, 3, 20);
    when(() => mockMoodRepository.watchMoods(date: date))
>>>>>>> origin/main
        .thenAnswer((_) => Stream.error(Exception('Database error')));

    // when
    // then
<<<<<<< HEAD
    container.read(homeProvider).when(
          data: (data) {
            // then
            expect(
              data,
              throwsA(isA<Exception>()),
            );
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: dateRange)).called(1);
  });

  test('should update moods when date range changes', () async {
    // given
    final initialDateRange = dateRange;
    final newDateRange = DateTimeRange(
      start: DateTime(2024, 3, 21),
      end: DateTime(2024, 3, 21),
    );
    final initialMoods = [
      MoodModel(
        id: 1,
        moodCategory: MoodCategory.happy,
        description: 'Initial mood',
        createdAt: initialDateRange.start,
      ),
    ];
    final newMoods = [
      MoodModel(
        id: 2,
        moodCategory: MoodCategory.sad,
        description: 'New mood',
        createdAt: newDateRange.start,
      ),
    ];

    when(() => mockMoodRepository.watchMoods(dateRange: initialDateRange))
        .thenAnswer((_) => Stream.value(initialMoods));
    when(() => mockMoodRepository.watchMoods(dateRange: newDateRange))
        .thenAnswer((_) => Stream.value(newMoods));

    // when
    container.updateOverrides([
      moodRepository.overrideWith(() => mockMoodRepository),
      homeDateRangeProvider.overrideWith((ref) => newDateRange),
    ]);

    // then
    container.read(homeProvider).when(
          data: (data) {
            expect(data.length, 1);
            expect(data[0].moodCategory, equals(MoodCategory.sad));
            expect(data[0].description, equals('New mood'));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: newDateRange))
        .called(1);
=======
    expect(
      () => container.read(homeProvider(date).future),
      throwsA(isA<Exception>()),
    );
    verify(() => mockMoodRepository.watchMoods(date: date)).called(1);
>>>>>>> origin/main
  });
}
