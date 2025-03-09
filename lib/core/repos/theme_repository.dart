import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  final SharedPreferencesAsync _asyncPref = SharedPreferencesAsync();

  Future<void> setTheme(String theme) async {
    await _asyncPref.setString("theme", theme);
  }

  Future<String?> getTheme() async {
    return await _asyncPref.getString("theme");
  }
}

final themeRepo = Provider.autoDispose(
  (ref) => ThemeRepository(),
);
