import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/home/provider/provider.dart';

import '../../mock.dart';

void main() {
  final date = DateTime(2024, 3, 20);
  final dateRange = DateTimeRange(
    start: date,
    end: date,
  );
  late MockMoodRepository mockMoodRepository;
  late ProviderContainer container;

  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
        moodRepository.overrideWith(() => mockMoodRepository),
        homeDateRangeProvider.overrideWith((ref) => dateRange),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should return empty list when no moods exist', () async {
    // given
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
  });

  test('should return list of moods when they exist', () async {
    // given
    final mockMoods = [
      MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: 'Great day!',
        createdAt: dateRange.start,
      ),
      MoodModel(
        id: 2,
        moodType: MoodType.angry,
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
            expect(data[0].moodType, equals(MoodType.happy));
            expect(data[1].moodType, equals(MoodType.angry));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: dateRange)).called(1);
  });

  test('should handle null date range parameter', () async {
    // given
    final mockMoods = [
      MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: 'Today is good',
        createdAt: DateTime.now(),
      ),
    ];
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
            expect(data[0].moodType, equals(MoodType.happy));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: null)).called(1);
  });

  test('should format date correctly', () {
    // given
    final testDate = date;

    // when
    final viewModel = container.read(homeProvider.notifier);
    final formattedDate = viewModel.formatDate(testDate);

    // then
    expect(formattedDate, equals('Wed, Mar 20'));
  });

  test('should handle stream error', () async {
    // given
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.error(Exception('Database error')));

    // when
    // then
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
        moodType: MoodType.happy,
        description: 'Initial mood',
        createdAt: initialDateRange.start,
      ),
    ];
    final newMoods = [
      MoodModel(
        id: 2,
        moodType: MoodType.sad,
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
            expect(data[0].moodType, equals(MoodType.sad));
            expect(data[0].description, equals('New mood'));
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
    verify(() => mockMoodRepository.watchMoods(dateRange: newDateRange))
        .called(1);
  });
}
