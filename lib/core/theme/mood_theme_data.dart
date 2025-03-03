import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/mood_color.dart';
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
      color: MoodColor.lightgrey,
    ),
    textTheme: GoogleFonts.dongleTextTheme().apply(
      bodyColor: MoodColor.black,
      displayColor: MoodColor.black,
    ),
  );
}
