import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:moodtracker/features/settings/view_models/fonts_view_model.dart';
import 'package:moodtracker/features/settings/view_models/theme_view_model.dart';

final fontsProvider =
    NotifierProvider.autoDispose<FontsViewModel, AsyncValue<AppFontsType>>(
  () => FontsViewModel(),
);

final themeProvider =
    NotifierProvider.autoDispose<ThemeViewModel, AsyncValue<AppThemeType>>(
  () => ThemeViewModel(),
);
