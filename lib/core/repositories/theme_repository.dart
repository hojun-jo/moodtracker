import 'package:moodtracker/core/theme/app_theme_type.dart';

abstract class ThemeRepository {
  Future<AppThemeType> getTheme();
  Future<void> setTheme(AppThemeType theme);
}
