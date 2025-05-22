import 'package:moodtracker/core/datasources/interfaces/theme_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDatasourceImpl extends ThemeDatasource {
  static const _theme = "theme";
  static const _fonts = "fonts";

  final SharedPreferencesAsync asyncPref;

  ThemeLocalDatasourceImpl({required this.asyncPref});

  @override
  Future<void> setTheme(String theme) async {
    await asyncPref.setString(_theme, theme);
  }

  @override
  Future<String?> getTheme() async {
    return await asyncPref.getString(_theme);
  }

  @override
  Future<void> setFonts(String fonts) async {
    await asyncPref.setString(_fonts, fonts);
  }

  @override
  Future<String?> getFonts() async {
    return await asyncPref.getString(_fonts);
  }
}
