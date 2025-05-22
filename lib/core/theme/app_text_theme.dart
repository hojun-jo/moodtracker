import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';

abstract class AppTextTheme {
  AppTextTheme._();

  static TextTheme? data(Locale locale, AppFontsType fonts) {
    return locale.languageCode == "ja"
        ? null
        : fonts.theme.copyWith(
            titleSmall: fonts.style.copyWith(
              color: AppColor.black,
              fontSize: _titleSamllSize(fonts),
            ),
            bodyLarge: fonts.style.copyWith(
              color: AppColor.black,
              fontSize: _bodyLargeSize(fonts),
            ),
            bodyMedium: fonts.style.copyWith(
              color: AppColor.black,
              fontSize: _bodyMediumSize(fonts),
            ),
            bodySmall: fonts.style.copyWith(
              color: AppColor.grey,
              fontSize: _bodySamllSize(fonts),
            ),
          );
  }

  static double _titleSamllSize(AppFontsType fonts) {
    switch (fonts) {
      case AppFontsType.jua:
        return 22;
      case AppFontsType.hiMelody:
        return 22;
      case AppFontsType.cute:
        return 24;
      case AppFontsType.nanumGothic:
        return 20;
      case AppFontsType.nanumMyeongjo:
        return 20;
    }
  }

  static double _bodyLargeSize(AppFontsType fonts) {
    switch (fonts) {
      case AppFontsType.jua:
        return 24;
      case AppFontsType.hiMelody:
        return 28;
      case AppFontsType.cute:
        return 26;
      case AppFontsType.nanumGothic:
        return 22;
      case AppFontsType.nanumMyeongjo:
        return 22;
    }
  }

  static double _bodyMediumSize(AppFontsType fonts) {
    switch (fonts) {
      case AppFontsType.jua:
        return 18;
      case AppFontsType.hiMelody:
        return 20;
      case AppFontsType.cute:
        return 22;
      case AppFontsType.nanumGothic:
        return 16;
      case AppFontsType.nanumMyeongjo:
        return 16;
    }
  }

  static double _bodySamllSize(AppFontsType fonts) {
    switch (fonts) {
      case AppFontsType.jua:
        return 14;
      case AppFontsType.hiMelody:
        return 14;
      case AppFontsType.cute:
        return 16;
      case AppFontsType.nanumGothic:
        return 12;
      case AppFontsType.nanumMyeongjo:
        return 12;
    }
  }
}
