import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/features/write/view_models/write_view_model.dart';

import '../../mock.dart';

void main() {
  late ProviderContainer container;
  late MockMoodRepository mockMoodRepository;
  late WriteViewModel writeViewModel;

  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
        moodRepository.overrideWith(() => mockMoodRepository),
      ],
    );
    writeViewModel = container.read(writeProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('should successfully post mood with valid data', () async {
    // Given
    const mood = MoodCategory.happy;
    const description = 'I had a great day!';

    when(() => mockMoodRepository.addMood(mood, description))
        .thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, description);

    // Then
    verify(() => mockMoodRepository.addMood(mood, description)).called(1);
  });

  test('should handle empty description', () async {
    // Given
    const mood = MoodCategory.happy;
    const emptyDescription = '';

    when(() => mockMoodRepository.addMood(mood, emptyDescription))
        .thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, emptyDescription);

    // Then
    verify(() => mockMoodRepository.addMood(mood, emptyDescription)).called(1);
  });

  test('should handle very long description', () async {
    // Given
    const mood = MoodCategory.angry;
    final longDescription = 'a' * 1000;

    when(() => mockMoodRepository.addMood(mood, longDescription))
        .thenAnswer((_) async {});

    // When
    await writeViewModel.post(mood, longDescription);

    // Then
    verify(() => mockMoodRepository.addMood(mood, longDescription)).called(1);
  });

  test('should handle repository error', () async {
    // Given
    const mood = MoodCategory.angry;
    const description = 'I am frustrated';

    when(() => mockMoodRepository.addMood(mood, description))
        .thenThrow(Exception('Database error'));

    // When & Then
    expect(
      () => writeViewModel.post(mood, description),
      throwsA(isA<Exception>()),
    );
  });

  test('should handle all mood types', () async {
    // Given
    const allMoodTypes = MoodCategory.values;
    const description = 'Testing all mood types';

    for (final mood in allMoodTypes) {
      when(() => mockMoodRepository.addMood(mood, description))
          .thenAnswer((_) async {});

      // When
      await writeViewModel.post(mood, description);

      // Then
      verify(() => mockMoodRepository.addMood(mood, description)).called(1);
    }
  });
}
