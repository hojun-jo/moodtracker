import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';

import '../../mock.dart';

void main() {
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

  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
        moodRepository.overrideWith((ref) => mockMoodRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should return empty list when no moods exist', () async {
    // given
    final date = DateTime(2024, 3, 20);
    when(() => mockMoodRepository.watchMoods(date: date))
        .thenAnswer((_) => Stream.value([]));

    // when
    final futureResult = container.read(homeProvider(date).future);

    // then
    await expectLater(futureResult, completion(isEmpty));
    verify(() => mockMoodRepository.watchMoods(date: date)).called(1);
  });

  test('should return list of moods when they exist', () async {
    // given
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
    // given
    final mockMoods = [
      MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: 'Today is good',
        createdAt: DateTime.now(),
      ),
    ];
    when(() => mockMoodRepository.watchMoods(date: null))
        .thenAnswer((_) => Stream.value(mockMoods));

    // when
    final futureResult = container.read(homeProvider(null).future);
    final moods = await futureResult;

    // then
    expect(moods, hasLength(1));
    expect(moods[0].moodType, equals(MoodType.happy));
    verify(() => mockMoodRepository.watchMoods(date: null)).called(1);
  });

  test('should format date correctly', () {
    // given
    final date = DateTime(2024, 3, 20);

    // when
    final formattedDate =
        container.read(homeProvider(null).notifier).formatDate(date);

    // then
    expect(formattedDate, equals('Wed, Mar 20'));
  });

  test('should handle stream error gracefully', () async {
    // given
    final date = DateTime(2024, 3, 20);
    when(() => mockMoodRepository.watchMoods(date: date))
        .thenAnswer((_) => Stream.error(Exception('Database error')));

    // when
    // then
    expect(
      () => container.read(homeProvider(date).future),
      throwsA(isA<Exception>()),
    );
    verify(() => mockMoodRepository.watchMoods(date: date)).called(1);
  });
}
