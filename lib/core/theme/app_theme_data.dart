import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/theme/app_text_theme.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

<<<<<<< HEAD
ThemeData appThemeData(
  AppThemeType appBackground,
  Locale locale,
) {
  final appBackgroundColor = appBackground.toColor();
  final textBodySmall = AppTextTheme.data(locale)?.bodySmall;
  final textBodyMedium = AppTextTheme.data(locale)?.bodyMedium;

=======
ThemeData appThemeData(AppThemeType appBackground, Locale locale) {
>>>>>>> origin/main
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
<<<<<<< HEAD
      hintStyle: textBodySmall,
      labelStyle: textBodySmall,
=======
      hintStyle: AppTextTheme.data(locale)?.bodySmall,
>>>>>>> origin/main
    ),
    textTheme: AppTextTheme.data(locale),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,
      selectionColor: appBackgroundColor,
      selectionHandleColor: appBackgroundColor,
    ),
<<<<<<< HEAD
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.black),
        textStyle: WidgetStateProperty.all(
          textBodyMedium,
        ),
      ),
    ),
    cardColor: appBackgroundColor,
=======
    cardColor: appBackground.toColor(),
>>>>>>> origin/main
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColor.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColor.white,
<<<<<<< HEAD
      titleTextStyle: textBodyMedium,
=======
      titleTextStyle: AppTextTheme.data(locale)?.bodyMedium,
>>>>>>> origin/main
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
<<<<<<< HEAD
      rangePickerBackgroundColor: AppColor.white,
      rangeSelectionBackgroundColor: appBackgroundColor,
      rangePickerHeaderHelpStyle: textBodySmall,
      headerHeadlineStyle: textBodySmall,
      headerHelpStyle: textBodySmall,
=======
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.black),
        textStyle: WidgetStateProperty.all(
          AppTextTheme.data(locale)?.bodySmall,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.black),
        textStyle: WidgetStateProperty.all(
          AppTextTheme.data(locale)?.bodySmall,
        ),
      ),
      headerHelpStyle: AppTextTheme.data(locale)?.bodySmall,
      weekdayStyle: AppTextTheme.data(locale)?.bodySmall,
      dayStyle: AppTextTheme.data(locale)?.bodySmall,
      yearStyle: AppTextTheme.data(locale)?.bodySmall,
>>>>>>> origin/main
    ),
  );
}
