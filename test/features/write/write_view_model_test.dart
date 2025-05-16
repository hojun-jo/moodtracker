import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
<<<<<<< HEAD
import 'package:moodtracker/core/models/mood/mood_category.dart';
=======
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
>>>>>>> origin/main
import 'package:moodtracker/features/write/view_models/write_view_model.dart';

import '../../mock.dart';

void main() {
  late ProviderContainer container;
  late MockMoodRepository mockMoodRepository;
  late WriteViewModel writeViewModel;

<<<<<<< HEAD
=======
  setUpAll(() {
    registerFallbackValue(MoodModel(
      id: 0,
      moodType: MoodType.happy,
      description: '',
      createdAt: DateTime(0),
    ));
  });

>>>>>>> origin/main
  setUp(() {
    mockMoodRepository = MockMoodRepository();
    container = ProviderContainer(
      overrides: [
<<<<<<< HEAD
        moodRepository.overrideWith(() => mockMoodRepository),
=======
        moodRepository.overrideWith((ref) => mockMoodRepository),
>>>>>>> origin/main
      ],
    );
    writeViewModel = container.read(writeProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('should successfully post mood with valid data', () async {
    // Given
<<<<<<< HEAD
    const mood = MoodCategory.happy;
    const description = 'I had a great day!';

    when(() => mockMoodRepository.addMood(mood, description))
        .thenAnswer((_) async {});
=======
    const mood = MoodType.happy;
    const description = 'I had a great day!';

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});
>>>>>>> origin/main

    // When
    await writeViewModel.post(mood, description);

    // Then
<<<<<<< HEAD
    verify(() => mockMoodRepository.addMood(mood, description)).called(1);
=======
    verify(() => mockMoodRepository.addMood(any())).called(1);
>>>>>>> origin/main
  });

  test('should handle empty description', () async {
    // Given
<<<<<<< HEAD
    const mood = MoodCategory.happy;
    const emptyDescription = '';

    when(() => mockMoodRepository.addMood(mood, emptyDescription))
        .thenAnswer((_) async {});
=======
    const mood = MoodType.happy;
    const emptyDescription = '';

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});
>>>>>>> origin/main

    // When
    await writeViewModel.post(mood, emptyDescription);

    // Then
<<<<<<< HEAD
    verify(() => mockMoodRepository.addMood(mood, emptyDescription)).called(1);
=======
    verify(() => mockMoodRepository.addMood(any())).called(1);
>>>>>>> origin/main
  });

  test('should handle very long description', () async {
    // Given
<<<<<<< HEAD
    const mood = MoodCategory.angry;
    final longDescription = 'a' * 1000;

    when(() => mockMoodRepository.addMood(mood, longDescription))
        .thenAnswer((_) async {});
=======
    const mood = MoodType.angry;
    final longDescription = 'a' * 1000;

    when(() => mockMoodRepository.addMood(any())).thenAnswer((_) async {});
>>>>>>> origin/main

    // When
    await writeViewModel.post(mood, longDescription);

    // Then
<<<<<<< HEAD
    verify(() => mockMoodRepository.addMood(mood, longDescription)).called(1);
=======
    verify(() => mockMoodRepository.addMood(any())).called(1);
>>>>>>> origin/main
  });

  test('should handle repository error', () async {
    // Given
<<<<<<< HEAD
    const mood = MoodCategory.angry;
    const description = 'I am frustrated';

    when(() => mockMoodRepository.addMood(mood, description))
=======
    const mood = MoodType.angry;
    const description = 'I am frustrated';

    when(() => mockMoodRepository.addMood(any()))
>>>>>>> origin/main
        .thenThrow(Exception('Database error'));

    // When & Then
    expect(
      () => writeViewModel.post(mood, description),
      throwsA(isA<Exception>()),
    );
  });

  test('should handle all mood types', () async {
    // Given
<<<<<<< HEAD
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
=======
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
>>>>>>> origin/main
  });
}
