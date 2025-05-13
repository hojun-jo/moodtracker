import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/chart/repositories/sample_chart_repository.dart';

import '../../../mock.dart';

void main() {
  late ProviderContainer container;
  late SampleChartRepository repository;
  late MockFileLoader mockFileLoader;

  setUp(() {
    mockFileLoader = MockFileLoader();
    container = ProviderContainer();
    repository = SampleChartRepository(fileLoader: mockFileLoader);
  });

  tearDown(() {
    container.dispose();
  });

  test('given valid json, when build is called, then returns list of MoodModel',
      () async {
    // given
    mockFileLoader.mockData = '''
    [
      {
        "id": 1,
        "moodType": 4,
        "description": "드디어 새 달 시작!",
        "createdAt": 1743403800000000
      },
      {
        "id": 2,
        "moodType": 2,
        "description": "오후에는 그냥 내가 좋아하는 노래 들으면서 좀 쉬었어.",
        "createdAt": 1743424500000000
      }
    ]
    ''';

    // when
    final result = await repository.build();

    // then
    expect(result.length, 2);
    expect(result[0].id, 1);
    expect(result[0].moodType, MoodType.happy);
    expect(result[0].description, "드디어 새 달 시작!");
    expect(result[0].createdAt,
        DateTime.fromMicrosecondsSinceEpoch(1743403800000000));

    expect(result[1].id, 2);
    expect(result[1].moodType, MoodType.calm);
    expect(result[1].description, "오후에는 그냥 내가 좋아하는 노래 들으면서 좀 쉬었어.");
    expect(result[1].createdAt,
        DateTime.fromMicrosecondsSinceEpoch(1743424500000000));
  });

  test('given invalid mood type, when build is called, then throws Exception',
      () async {
    // given
    mockFileLoader.mockData = '''
    [
      {
        "id": 1,
        "moodType": 999,
        "description": "Invalid mood type",
        "createdAt": 1743403800000000
      }
    ]
    ''';

    // when & then
    expect(() => repository.build(), throwsA(isA<Exception>()));
  });

  test('given invalid json, when build is called, then throws FormatException',
      () async {
    // given
    mockFileLoader.mockData = 'invalid json';

    // when, then
    expect(() => repository.build(), throwsA(isA<FormatException>()));
  });

  test('given file not found, when build is called, then throws Exception',
      () async {
    // given
    mockFileLoader.mockData = null;

    // when, then
    expect(() => repository.build(), throwsA(isA<Exception>()));
  });
}
