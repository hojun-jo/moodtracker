import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/datasources/mood_datasource.dart';
import 'package:moodtracker/core/infra/repositories/mood_repository_impl.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

import '../../../mock.dart';

void main() {
  late MoodRepositoryImpl repository;
  late MockMoodLocalDatasource mockDatasource;
  late Future<MoodDatasource> futureDatasource;

  setUp(() {
    mockDatasource = MockMoodLocalDatasource();
    futureDatasource = Future.value(mockDatasource);
    repository = MoodRepositoryImpl(moodDatasource: futureDatasource);
  });

  group('addMood', () {
    test('should successfully add mood', () async {
      // given
      final mood = MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: "happy",
        createdAt: DateTime.now(),
      );
      when(() => mockDatasource.addMood(mood)).thenAnswer((_) async {});

      // when
      await repository.addMood(mood);

      // then
      verify(() => mockDatasource.addMood(mood)).called(1);
    });

    test('should handle error when adding mood fails', () async {
      // given
      final mood = MoodModel(
        id: 1,
        moodType: MoodType.happy,
        description: "happy",
        createdAt: DateTime.now(),
      );
      when(() => mockDatasource.addMood(mood))
          .thenThrow(Exception('Failed to add mood'));

      // when
      // then
      expect(() => repository.addMood(mood), throwsException);
    });
  });

  group('watchMoods', () {
    test('should stream moods without date filter', () async {
      // given
      final moods = [
        MoodModel(
          id: 1,
          moodType: MoodType.happy,
          description: "happy",
          createdAt: DateTime.now(),
        ),
        MoodModel(
          id: 2,
          moodType: MoodType.angry,
          description: "bad",
          createdAt: DateTime.now(),
        ),
      ];
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.value(moods));

      // when
      final stream = repository.watchMoods();

      // then
      expect(stream, emits(moods));
    });

    test('should stream moods with date filter', () async {
      // given
      final date = DateTime(2024, 3, 20);
      final moods = [
        MoodModel(
          id: 1,
          moodType: MoodType.happy,
          description: "happy",
          createdAt: date,
        ),
      ];
      when(() => mockDatasource.watchMoods(date: date))
          .thenAnswer((_) => Stream.value(moods));

      // when
      final stream = repository.watchMoods(date: date);

      // then
      expect(stream, emits(moods));
    });

    test('should handle empty mood list', () async {
      // given
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.value([]));

      // when
      final stream = repository.watchMoods();

      // then
      expect(stream, emits([]));
    });

    test('should handle error in mood stream', () async {
      // given
      when(() => mockDatasource.watchMoods())
          .thenAnswer((_) => Stream.error(Exception('Stream error')));

      // when
      final stream = repository.watchMoods();

      // then
      expect(stream, emitsError(isA<Exception>()));
    });
  });
}
