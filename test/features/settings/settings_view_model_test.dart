import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

import '../../fake/fake_theme_repository.dart';

void main() {
  late ProviderContainer container;
  late FakeThemeRepository fakeThemeRepository;

  setUp(() {
    fakeThemeRepository = FakeThemeRepository(
      initialTheme: AppThemeData(
        theme: AppThemeType.almond,
        fonts: AppFontsType.jua,
      ),
    );
    container = ProviderContainer(
      overrides: [
        themeRepository.overrideWith(() => fakeThemeRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    fakeThemeRepository.reset();
  });

  test('get theme should return default theme when repository returns null',
      () async {
    // given
    const expectedTheme = AppThemeType.almond;

    // when
    final themeData = await container.read(themeRepository.future);

    // then
    expect(themeData.theme, expectedTheme);
  });

  test('get theme should return theme from repository', () async {
    // given
    const expectedTheme = AppThemeType.apricot;

    fakeThemeRepository.stubGetTheme(() async => expectedTheme);

    // when
    final theme = await container.read(themeRepository.notifier).getTheme();

    // then
    expect(theme, expectedTheme);
    expect(fakeThemeRepository.getThemeCalled, isTrue);
  });

  test('set theme should call setTheme on repository', () async {
    // given
    const themeToSelect = AppThemeType.apricot;
    bool mockSetThemeCalled = false;

    fakeThemeRepository.stubSetTheme((theme) async {
      expect(theme, themeToSelect);
      mockSetThemeCalled = true;
    });

    // when
    await container.read(themeRepository.notifier).setTheme(themeToSelect);

    // then
    expect(fakeThemeRepository.setThemeCalled, isTrue);
    expect(fakeThemeRepository.lastSetThemeArg, themeToSelect);
    expect(mockSetThemeCalled, isTrue);
  });
}
