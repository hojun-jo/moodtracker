import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';

import '../../../mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockMoodRepository mockMoodRepository;
  late MockSampleChartRepository mockSampleChartRepository;
  late MockChartStateRepository mockChartStateRepository;
  late MockChartDateRangeRepository mockChartDateRangeRepository;

  final dateRange = DateTimeRange(
    start: DateTime(2024, 1, 1),
    end: DateTime(2024, 1, 31),
  );

  setUp(() {
    mockMoodRepository = MockMoodRepository();
    mockSampleChartRepository = MockSampleChartRepository();
    mockChartStateRepository = MockChartStateRepository();
    mockChartDateRangeRepository = MockChartDateRangeRepository();
    container = ProviderContainer(
      overrides: [
        moodRepository.overrideWith(() => mockMoodRepository),
        sampleChartProvider.overrideWith(() => mockSampleChartRepository),
        chartStateProvider.overrideWithValue(mockChartStateRepository),
        chartDateRangeProvider.overrideWith(() => mockChartDateRangeRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('returns mood type counts sorted by count when real data exists',
      () async {
    // given
    final moods = [
      MoodModel(
        id: 1,
        moodCategory: MoodCategory.happy,
        description: 'Happy day',
        createdAt: DateTime(2024, 1, 1),
      ),
      MoodModel(
        id: 2,
        moodCategory: MoodCategory.happy,
        description: 'Another happy day',
        createdAt: DateTime(2024, 1, 2),
      ),
      MoodModel(
        id: 3,
        moodCategory: MoodCategory.sad,
        description: 'Sad day',
        createdAt: DateTime(2024, 1, 3),
      ),
    ];
    when(() => mockChartDateRangeRepository.state).thenReturn(dateRange);
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value(moods));
    // when(() => mockChartStateRepository.setIsChartSample(any()))
    //     .thenReturn(null);

    // when, then
    container.read(moodFrequencyProvider).when(
          data: (data) {
            expect(data.length, MoodCategory.values.length);
            expect(data[0].category, MoodCategory.happy);
            expect(data[0].count, 2);
            expect(data[1].category, MoodCategory.sad);
            expect(data[1].count, 1);
          },
          error: (error, stackTrace) => fail('Unexpected error: $error'),
          loading: () => fail('Unexpected loading state'),
        );
    verify(() => mockChartStateRepository.setIsChartSample(false)).called(1);
  });

  test('returns sample data when real data is empty', () async {
    // given
    final sampleMoods = [
      MoodModel(
        id: 1,
        moodCategory: MoodCategory.happy,
        description: 'Sample happy day',
        createdAt: DateTime(2024, 1, 1),
      ),
      MoodModel(
        id: 2,
        moodCategory: MoodCategory.calm,
        description: 'Sample calm day',
        createdAt: DateTime(2024, 1, 2),
      ),
    ];
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value([]));
    when(() => mockSampleChartRepository.build())
        .thenAnswer((_) async => sampleMoods);
    when(() => mockChartStateRepository.setIsChartSample(any()))
        .thenReturn(null);

    // when
    final notifier = container.read(moodFrequencyProvider.notifier);
    final result = notifier.build();

    // then
    result.when(
      data: (data) {
        expect(data.length, MoodCategory.values.length);
        expect(data[0].category, MoodCategory.happy);
        expect(data[0].count, 1);
        expect(data[1].category, MoodCategory.calm);
        expect(data[1].count, 1);
      },
      error: (error, stackTrace) => fail('Unexpected error: $error'),
      loading: () => fail('Unexpected loading state'),
    );
    verify(() => mockChartStateRepository.setIsChartSample(true)).called(1);
  });

  test('returns loading state initially', () {
    // given
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value([]));
    when(() => mockSampleChartRepository.build()).thenAnswer((_) async => []);
    when(() => mockChartStateRepository.setIsChartSample(any()))
        .thenReturn(null);

    // when
    final state = container.read(moodFrequencyProvider);

    // then
    expect(state, const AsyncValue.loading());
  });

  test('throws error when mood repository fails', () async {
    // given
    final error = Exception('Failed to load moods');
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.error(error));
    when(() => mockChartStateRepository.setIsChartSample(any()))
        .thenReturn(null);

    // when, then
    final notifier = container.read(moodFrequencyProvider.notifier);
    expect(
      () => notifier.build(),
      throwsA(same(error)),
    );
  });

  test('throws error when sample chart repository fails', () async {
    // given
    final error = Exception('Failed to load sample data');
    when(() => mockMoodRepository.watchMoods(dateRange: dateRange))
        .thenAnswer((_) => Stream.value([]));
    when(() => mockSampleChartRepository.build()).thenThrow(error);
    when(() => mockChartStateRepository.setIsChartSample(any()))
        .thenReturn(null);

    // when, then
    final notifier = container.read(moodFrequencyProvider.notifier);
    expect(
      () => notifier.build(),
      throwsA(same(error)),
    );
  });
}
