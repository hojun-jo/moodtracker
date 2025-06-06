import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/theme/app_text_theme.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class AppThemeData {
  final AppThemeType theme;
  final AppFontsType fonts;

  AppThemeData({
    required this.theme,
    required this.fonts,
  });

  AppThemeData copyWith({
    AppThemeType? theme,
    AppFontsType? fonts,
  }) {
    return AppThemeData(
      theme: theme ?? this.theme,
      fonts: fonts ?? this.fonts,
    );
  }

  ThemeData getThemeData(Locale locale) {
    final appBackgroundColor = theme.toColor();
    final textTheme = AppTextTheme.data(locale, fonts);
    final textBodySmall = textTheme?.bodySmall;
    final textBodyMedium = textTheme?.bodyMedium;

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: appBackgroundColor,
        primary: appBackgroundColor,
        onPrimary: AppColor.black,
      ),
      scaffoldBackgroundColor: appBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBackgroundColor,
        surfaceTintColor: appBackgroundColor,
        iconTheme: const IconThemeData(
          color: AppColor.darkgrey,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColor.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: textBodySmall,
        labelStyle: textBodySmall,
      ),
      textTheme: textTheme,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.black,
        selectionColor: appBackgroundColor,
        selectionHandleColor: appBackgroundColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(AppColor.black),
          textStyle: WidgetStateProperty.all(
            textBodyMedium,
          ),
        ),
      ),
      cardColor: appBackgroundColor,
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColor.white,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: AppColor.white,
        titleTextStyle: textBodyMedium,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.black,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColor.white,
      ),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateColor.fromMap({
            WidgetState.any: AppColor.white,
          }),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColor.white,
        rangePickerBackgroundColor: AppColor.white,
        rangeSelectionBackgroundColor: appBackgroundColor,
        rangePickerHeaderHelpStyle: textBodySmall,
        headerHeadlineStyle: textBodySmall,
        headerHelpStyle: textBodySmall,
      ),
    );
  }
}
