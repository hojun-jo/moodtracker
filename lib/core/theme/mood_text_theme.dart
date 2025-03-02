import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/mood_color.dart';

abstract class MoodTextTheme {
  MoodTextTheme._();

  static final data = GoogleFonts.dongleTextTheme().apply(
    bodyColor: MoodColor.black,
    displayColor: MoodColor.black,
  );
}
