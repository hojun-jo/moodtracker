import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/mood_color.dart';

abstract class MoodTextTheme {
  MoodTextTheme._();

  static final data = GoogleFonts.dongleTextTheme().copyWith(
    bodyMedium: GoogleFonts.dongle(
      color: MoodColor.black,
      fontSize: 30,
    ),
    bodySmall: GoogleFonts.dongle(
      color: MoodColor.grey,
      fontSize: 24,
    ),
  );
}
