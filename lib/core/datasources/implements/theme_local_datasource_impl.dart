import 'package:moodtracker/core/datasources/interfaces/theme_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDatasourceImpl extends ThemeDatasource {
  final SharedPreferencesAsync asyncPref;

  ThemeLocalDatasourceImpl({required this.asyncPref});

  @override
  Future<void> setTheme(String theme) async {
    await asyncPref.setString("theme", theme);
  }

  @override
  Future<String?> getTheme() async {
    return await asyncPref.getString("theme");
  }
}
