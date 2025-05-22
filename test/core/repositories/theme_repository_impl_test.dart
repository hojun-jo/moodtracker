import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

import '../../mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    test(
        'return default theme data when datasource returns null for both theme and fonts',
        () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => null);
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => null);

      // When
      final result = await container.read(themeRepository.future);

      // Then
      expect(result.theme, AppThemeType.almond);
      expect(result.fonts, AppFontsType.jua);
    });

    test('return saved theme data when datasource returns saved values',
        () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => "Cherry Blossom");
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => "Nanum Gothic");

      // When
      final result = await container.read(themeRepository.future);

      // Then
      expect(result.theme, AppThemeType.cherryBlossom);
      expect(result.fonts, AppFontsType.nanumGothic);
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

  group("setTheme", () {
    test('save theme and update state', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => "Almond");
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => "Jua");
      when(() => mockThemeLocalDatasource.setTheme("Almond"))
          .thenAnswer((_) async {});

      await container.read(themeRepository.future);

      // When
      await container
          .read(themeRepository.notifier)
          .setTheme(AppThemeType.almond);

      // Then
      verify(() => mockThemeLocalDatasource.setTheme("Almond")).called(1);
      final state = await container.read(themeRepository.future);
      expect(state.theme, AppThemeType.almond);
      expect(state.fonts, AppFontsType.jua);
    });
  });

  group("getFonts", () {
    test('return default fonts when datasource returns null', () async {
      // Given
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => null);

      // When
      final result = await container.read(themeRepository.notifier).getFonts();

      // Then
      expect(result, AppFontsType.jua);
    });

    test('return saved fonts when datasource returns saved fonts', () async {
      // Given
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => "Nanum Gothic");

      // When
      final result = await container.read(themeRepository.notifier).getFonts();

      // Then
      expect(result, AppFontsType.nanumGothic);
    });

    test('return default fonts when datasource throws an error', () async {
      // Given
      when(() => mockThemeLocalDatasource.getFonts())
          .thenThrow(Exception("Error"));

      // When
      final result = await container.read(themeRepository.notifier).getFonts();

      // Then
      expect(result, AppFontsType.jua);
    });
  });

  group("setFonts", () {
    test('save fonts and update state', () async {
      // Given
      when(() => mockThemeLocalDatasource.getTheme())
          .thenAnswer((_) async => "Almond");
      when(() => mockThemeLocalDatasource.getFonts())
          .thenAnswer((_) async => "Jua");
      when(() => mockThemeLocalDatasource.setFonts("Nanum Gothic"))
          .thenAnswer((_) async {});

      await container.read(themeRepository.future);

      // When
      await container
          .read(themeRepository.notifier)
          .setFonts(AppFontsType.nanumGothic);

      // Then
      verify(() => mockThemeLocalDatasource.setFonts("Nanum Gothic")).called(1);
      final state = await container.read(themeRepository.future);
      expect(state.fonts, AppFontsType.nanumGothic);
      expect(state.theme, AppThemeType.almond);
    });
  });
}
