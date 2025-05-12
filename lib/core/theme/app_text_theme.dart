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
              height: 1.2,
            ),
            bodySmall: GoogleFonts.dongle(
              color: AppColor.grey,
              fontSize: 22,
              height: 1.2,
            ),
          );
  }
}
