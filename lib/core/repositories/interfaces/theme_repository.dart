import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

abstract interface class ThemeRepository
    extends AutoDisposeAsyncNotifier<AppThemeData> {
  Future<AppThemeType> getTheme();
  Future<void> setTheme(AppThemeType theme);
  Future<AppFontsType> getFonts();
  Future<void> setFonts(AppFontsType fonts);
}
