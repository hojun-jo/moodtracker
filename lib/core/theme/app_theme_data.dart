import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/theme/app_text_theme.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

ThemeData appThemeData(AppThemeType appBackground) {
  return ThemeData(
    scaffoldBackgroundColor: appBackground.toColor(),
    appBarTheme: AppBarTheme(
      backgroundColor: appBackground.toColor(),
      surfaceTintColor: appBackground.toColor(),
      iconTheme: const IconThemeData(
        color: AppColor.darkgrey,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColor.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: AppTextTheme.data.bodySmall,
    ),
    textTheme: AppTextTheme.data,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,
      selectionColor: appBackground.toColor(),
      selectionHandleColor: appBackground.toColor(),
    ),
    cardColor: appBackground.toColor(),
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColor.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColor.white,
      titleTextStyle: AppTextTheme.data.bodyMedium,
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
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.black),
        textStyle: WidgetStateProperty.all(
          AppTextTheme.data.bodySmall,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColor.black),
        textStyle: WidgetStateProperty.all(
          AppTextTheme.data.bodySmall,
        ),
      ),
      headerHelpStyle: AppTextTheme.data.bodySmall,
      weekdayStyle: AppTextTheme.data.bodySmall,
      dayStyle: AppTextTheme.data.bodySmall,
      yearStyle: AppTextTheme.data.bodySmall,
    ),
  );
}
