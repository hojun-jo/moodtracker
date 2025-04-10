import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/app_color.dart';

abstract class AppTextTheme {
  AppTextTheme._();

  static final data = GoogleFonts.dongleTextTheme().copyWith(
    bodyMedium: GoogleFonts.dongle(
      color: AppColor.black,
      fontSize: 30,
      height: 1.2,
    ),
    bodySmall: GoogleFonts.dongle(
      color: AppColor.grey,
      fontSize: 24,
      height: 1.2,
    ),
  );
}
