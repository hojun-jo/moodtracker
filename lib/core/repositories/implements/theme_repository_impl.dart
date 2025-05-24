import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/datasources/interfaces/theme_datasource.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/repositories/interfaces/theme_repository.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class ThemeRepositoryImpl extends AutoDisposeAsyncNotifier<AppThemeData>
    implements ThemeRepository {
  late final ThemeDatasource _themeLocalDatasource;

  @override
  FutureOr<AppThemeData> build() async {
    _themeLocalDatasource = ref.read(themeLocalDatasource);
    final theme = await getTheme();
    final fonts = await getFonts();

    return AppThemeData(theme: theme, fonts: fonts);
  }

  @override
  Future<AppThemeType> getTheme() async {
    try {
      final theme = await _themeLocalDatasource.getTheme();

      if (theme == null) {
        return AppThemeType.almond;
      }

      return AppThemeType.fromString(theme);
    } catch (e) {
      return AppThemeType.almond;
    }
  }

  @override
  Future<void> setTheme(AppThemeType theme) async {
    final current = state.value!;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _themeLocalDatasource.setTheme(theme.text);

      return current.copyWith(theme: theme);
    });
  }

  @override
  Future<AppFontsType> getFonts() async {
    try {
      final fonts = await _themeLocalDatasource.getFonts();

      if (fonts == null) {
        return AppFontsType.jua;
      }

      return AppFontsType.fromString(fonts);
    } catch (e) {
      return AppFontsType.jua;
    }
  }

  @override
  Future<void> setFonts(AppFontsType fonts) async {
    final current = state.value!;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _themeLocalDatasource.setFonts(fonts.text);

      return current.copyWith(fonts: fonts);
    });
  }
}
