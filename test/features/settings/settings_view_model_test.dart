import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

import '../../fake/fake_theme_repository.dart';

void main() {
  late ProviderContainer container;
  late FakeThemeRepository fakeThemeRepository;

  setUp(() {
    fakeThemeRepository = FakeThemeRepository();
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

  test('selectTheme should call setTheme on repository', () async {
    // given
    const themeToSelect = AppThemeType.apricot;
    bool mockSetThemeCalled = false;

    fakeThemeRepository.stubSetTheme((theme) async {
      expect(theme, themeToSelect); // 인자 검증
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
