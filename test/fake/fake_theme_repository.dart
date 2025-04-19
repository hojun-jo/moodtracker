import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/repositories/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class FakeThemeRepository extends AutoDisposeAsyncNotifier<AppThemeType>
    implements ThemeRepository {
  final AppThemeType initialTheme;

  Future<AppThemeType> Function()? _getThemeMock;
  Future<void> Function(AppThemeType)? _setThemeMock;

  bool getThemeCalled = false;
  bool setThemeCalled = false;
  AppThemeType? lastSetThemeArg;

  FakeThemeRepository({this.initialTheme = AppThemeType.almond});

  @override
  FutureOr<AppThemeType> build() {
    return _getThemeMock != null ? _getThemeMock!() : initialTheme;
  }

  @override
  Future<AppThemeType> getTheme() async {
    getThemeCalled = true;
    if (_getThemeMock != null) {
      return await _getThemeMock!();
    }

    return state.value ?? initialTheme;
  }

  @override
  Future<void> setTheme(AppThemeType theme) async {
    setThemeCalled = true;
    lastSetThemeArg = theme;
    state = AsyncData(theme);
    if (_setThemeMock != null) {
      await _setThemeMock!(theme);
    }
  }

  void stubGetTheme(Future<AppThemeType> Function() func) =>
      _getThemeMock = func;
  void stubSetTheme(Future<void> Function(AppThemeType) func) =>
      _setThemeMock = func;

  void reset() {
    getThemeCalled = false;
    setThemeCalled = false;
    lastSetThemeArg = null;
    _getThemeMock = null;
    _setThemeMock = null;
  }
}
