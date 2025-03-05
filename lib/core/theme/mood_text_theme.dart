import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/mood_color.dart';

abstract class MoodTextTheme {
  MoodTextTheme._();

  static final data = TextTheme(
    bodyMedium: GoogleFonts.dongle(
      fontSize: 18,
    ),
  );
}
