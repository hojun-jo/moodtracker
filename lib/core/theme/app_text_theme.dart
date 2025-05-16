import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodtracker/core/theme/app_color.dart';

abstract class AppTextTheme {
  AppTextTheme._();
// TODO: jua, hi melody, cute font
  static TextTheme? data(Locale locale) {
    return locale.languageCode == "ja"
        ? null
        : GoogleFonts.dongleTextTheme().copyWith(
<<<<<<< HEAD
            titleSmall: GoogleFonts.dongle(
              color: AppColor.black,
              fontSize: 24,
              height: 1.2,
            ),
            bodyLarge: GoogleFonts.dongle(
              color: AppColor.black,
              fontSize: 32,
              height: 1.2,
            ),
            bodyMedium: GoogleFonts.dongle(
              color: AppColor.black,
              fontSize: 28,
=======
            bodyMedium: GoogleFonts.dongle(
              color: AppColor.black,
              fontSize: 30,
>>>>>>> origin/main
              height: 1.2,
            ),
            bodySmall: GoogleFonts.dongle(
              color: AppColor.grey,
<<<<<<< HEAD
              fontSize: 22,
=======
              fontSize: 24,
>>>>>>> origin/main
              height: 1.2,
            ),
          );
  }
}
