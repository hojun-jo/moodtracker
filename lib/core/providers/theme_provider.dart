import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/repos/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class ThemeNotifier extends AutoDisposeAsyncNotifier<AppThemeType> {
  late final ThemeRepository _themeRepository;

  @override
  FutureOr<AppThemeType> build() async {
    _themeRepository = ref.read(themeRepo);
    final theme = await _themeRepository.getTheme();

    if (theme == null) {
      return AppThemeType.almond;
    }

    return AppThemeType.fromString(theme);
  }

  Future<void> setTheme(AppThemeType theme) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _themeRepository.setTheme(theme.text);

      return theme;
    });
  }
}

final themeProvider =
    AsyncNotifierProvider.autoDispose<ThemeNotifier, AppThemeType>(
  () => ThemeNotifier(),
);
