import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/write/view_models/write_view_model.dart';

import '../../mock.dart';

void main() {
  late ProviderContainer container;
  late MockMoodRepository mockMoodRepository;
  late WriteViewModel writeViewModel;

  setUpAll(() {
    registerFallbackValue(MoodModel(
      id: 0,
      moodType: MoodType.smile,
      description: '',
      createdAt: DateTime(0),
    ));
  });

  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
        moodRepository.overrideWith((ref) => mockMoodRepository),
      ],
    );
    writeViewModel = container.read(writeProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('should successfully post mood with valid data', () async {
    // Given
    const mood = MoodType.smile;
    const description = 'I had a great day!';

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, description);

    // Then
    verify(() => mockMoodRepository.addMood(any())).called(1);
  });

  test('should handle empty description', () async {
    // Given
    const mood = MoodType.blank;
    const emptyDescription = '';

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, emptyDescription);

    // Then
    verify(() => mockMoodRepository.addMood(any())).called(1);
  });

  test('should handle very long description', () async {
    // Given
    const mood = MoodType.angry;
    final longDescription = 'a' * 1000;

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, longDescription);

    // Then
    verify(() => mockMoodRepository.addMood(any())).called(1);
  });

  test('should handle repository error', () async {
    // Given
    const mood = MoodType.angry;
    const description = 'I am frustrated';

    when(() => mockMoodRepository.addMood(any()))
        .thenThrow(Exception('Database error'));

    // When & Then
    expect(
      () => writeViewModel.post(mood, description),
      throwsA(isA<Exception>()),
    );
  });

  test('should handle all mood types', () async {
    // Given
    const allMoodTypes = MoodType.values;
    const description = 'Testing all mood types';

    for (final _ in allMoodTypes) {
      when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});
    }

    // When
    for (final mood in allMoodTypes) {
      await writeViewModel.post(mood, description);
    }

    // Then
    verify(() => mockMoodRepository.addMood(any())).called(allMoodTypes.length);
  });
}
