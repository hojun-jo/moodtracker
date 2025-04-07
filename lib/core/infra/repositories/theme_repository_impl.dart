import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/datasources/theme_datasource.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/repositories/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class ThemeRepositoryImpl extends AutoDisposeAsyncNotifier<AppThemeType>
    implements ThemeRepository {
  late final ThemeDatasource _themeLocalDatasource;

  @override
  FutureOr<AppThemeType> build() {
    _themeLocalDatasource = ref.read(themeLocalDatasource);

    return getTheme();
  }

  @override
  Future<AppThemeType> getTheme() async {
    final theme = await _themeLocalDatasource.getTheme();

    if (theme == null) {
      return AppThemeType.almond;
    }

    return AppThemeType.fromString(theme);
  }

  @override
  Future<void> setTheme(AppThemeType theme) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _themeLocalDatasource.setTheme(theme.text);

      return theme;
    });
  }
}
