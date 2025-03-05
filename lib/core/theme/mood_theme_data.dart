import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/mood_color.dart';
import 'package:moodtracker/core/theme/mood_text_theme.dart';
import 'package:moodtracker/core/theme/mood_theme_type.dart';

ThemeData moodThemeData(MoodThemeType appBackground) {
  return ThemeData(
    scaffoldBackgroundColor: appBackground.toColor(),
    appBarTheme: AppBarTheme(
      backgroundColor: appBackground.toColor(),
      iconTheme: const IconThemeData(
        color: MoodColor.darkgrey,
      ),
    ),
    iconTheme: const IconThemeData(
      color: MoodColor.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: MoodTextTheme.data.bodySmall,
    ),
    textTheme: MoodTextTheme.data,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MoodColor.black,
      selectionColor: appBackground.toColor(),
      selectionHandleColor: appBackground.toColor(),
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: MoodColor.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: MoodColor.white,
      titleTextStyle: MoodTextTheme.data.bodyMedium,
    ),
  );
}
