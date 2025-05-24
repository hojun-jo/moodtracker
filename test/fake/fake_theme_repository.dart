import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/repositories/interfaces/theme_repository.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class FakeThemeRepository extends AutoDisposeAsyncNotifier<AppThemeData>
    implements ThemeRepository {
  final AppThemeData initialTheme;

  Future<AppThemeType> Function()? _getThemeMock;
  Future<void> Function(AppThemeType)? _setThemeMock;
  Future<AppFontsType> Function()? _getFontsMock;
  Future<void> Function(AppFontsType)? _setFontsMock;

  bool getThemeCalled = false;
  bool setThemeCalled = false;
  bool getFontsCalled = false;
  bool setFontsCalled = false;
  AppThemeType? lastSetThemeArg;
  AppFontsType? lastSetFontsArg;

  FakeThemeRepository({required this.initialTheme});

  @override
  FutureOr<AppThemeData> build() {
    return initialTheme.copyWith(
      theme: lastSetThemeArg,
      fonts: lastSetFontsArg,
    );
  }

  @override
  Future<AppThemeType> getTheme() async {
    getThemeCalled = true;
    if (_getThemeMock != null) {
      return await _getThemeMock!();
    }

    return state.value?.theme ?? initialTheme.theme;
  }

  @override
  Future<void> setTheme(AppThemeType theme) async {
    setThemeCalled = true;
    lastSetThemeArg = theme;
    state = AsyncData(initialTheme.copyWith(theme: theme));
    if (_setThemeMock != null) {
      await _setThemeMock!(theme);
    }
  }

  @override
  Future<AppFontsType> getFonts() async {
    getFontsCalled = true;
    if (_getFontsMock != null) {
      return await _getFontsMock!();
    }

    return state.value?.fonts ?? initialTheme.fonts;
  }

  @override
  Future<void> setFonts(AppFontsType fonts) async {
    setFontsCalled = true;
    lastSetFontsArg = fonts;
    state = AsyncData(initialTheme.copyWith(fonts: fonts));
    if (_setFontsMock != null) {
      await _setFontsMock!(fonts);
    }
  }

  void stubGetTheme(Future<AppThemeType> Function() func) =>
      _getThemeMock = func;
  void stubSetTheme(Future<void> Function(AppThemeType) func) =>
      _setThemeMock = func;
  void stubGetFonts(Future<AppFontsType> Function() func) =>
      _getFontsMock = func;
  void stubSetFonts(Future<void> Function(AppFontsType) func) =>
      _setFontsMock = func;

  void reset() {
    getThemeCalled = false;
    setThemeCalled = false;
    getFontsCalled = false;
    setFontsCalled = false;
    lastSetThemeArg = null;
    lastSetFontsArg = null;
    _getThemeMock = null;
    _setThemeMock = null;
    _getFontsMock = null;
    _setFontsMock = null;
  }
}
