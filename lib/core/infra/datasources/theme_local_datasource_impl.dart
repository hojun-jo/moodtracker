import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/datasources/theme_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDatasourceImpl extends ThemeDatasource {
  final SharedPreferencesAsync _asyncPref = SharedPreferencesAsync();

  @override
  Future<void> setTheme(String theme) async {
    await _asyncPref.setString("theme", theme);
  }

  @override
  Future<String?> getTheme() async {
    return await _asyncPref.getString("theme");
  }
}

final themeLocalDatasource = Provider.autoDispose(
  (ref) => ThemeLocalDatasourceImpl(),
);
