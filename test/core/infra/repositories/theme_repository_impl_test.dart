import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

import '../../../mock.dart';

void main() {
  late ProviderContainer container;
  late MockThemeLocalDatasource mockThemeLocalDatasource;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    container = ProviderContainer(
      overrides: [
        themeLocalDatasource.overrideWithValue(mockThemeLocalDatasource),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group("build", () {
    test('return default theme when datasource returns null', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => null);

      // When
      final result = await container.read(themeRepository.future);

      // Then
      expect(result, AppThemeType.almond);
    });

    test('return saved theme when datasource returns saved theme', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => "Cherry Blossom");

      // When
      final result = await container.read(themeRepository.future);

      // Then
      expect(result, AppThemeType.cherryBlossom);
    });
  });

  group("getTheme", () {
    test('return default theme when datasource returns null', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => null);

      // When
      final result = await container.read(themeRepository.notifier).getTheme();

      // Then
      expect(result, AppThemeType.almond);
    });

    test('return saved theme when datasource returns saved theme', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => "Cherry Blossom");

      // When
      final result = await container.read(themeRepository.notifier).getTheme();

      // Then
      expect(result, AppThemeType.cherryBlossom);
    });

    test('return default theme when datasource throws an error', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenThrow(Exception("Error"));

      // When
      final result = await container.read(themeRepository.notifier).getTheme();

      // Then
      expect(result, AppThemeType.almond);
    });
  });

  group("saveTheme", () {
    test('save theme to datasource', () async {
      // Given
      when(() => mockThemeLocalDatasource.setTheme("Almond"))
          .thenAnswer((_) async => true);

      // When
      await container
          .read(themeRepository.notifier)
          .setTheme(AppThemeType.almond);

      // Then
      verify(() => mockThemeLocalDatasource.setTheme("Almond")).called(1);
    });
  });
}
