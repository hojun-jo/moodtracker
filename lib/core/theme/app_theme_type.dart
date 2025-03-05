import 'dart:ui';

import 'package:moodtracker/core/theme/app_color.dart';

enum AppThemeType {
  red,
  orange,
  white,
  green,
  purple;

  Color toColor() {
    switch (this) {
      case AppThemeType.red:
        return AppColor.appRed;
      case AppThemeType.orange:
        return AppColor.appOrange;
      case AppThemeType.white:
        return AppColor.appWhite;
      case AppThemeType.green:
        return AppColor.appGreen;
      case AppThemeType.purple:
        return AppColor.appPurple;
    }
  }
}
