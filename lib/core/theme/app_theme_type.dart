import 'dart:ui';

import 'package:moodtracker/core/theme/app_color.dart';

enum AppThemeType {
  cherryBlossom("cherryBlossom"),
  apricot("apricot"),
  almond("almond"),
  ashGray("ashGray"),
  thistle("thistle");

  final String text;

  const AppThemeType(this.text);

  factory AppThemeType.fromString(String text) {
    return values.firstWhere((e) => e.text == text);
  }

  Color toColor() {
    switch (this) {
      case AppThemeType.cherryBlossom:
        return AppColor.appCherryBlossom;
      case AppThemeType.apricot:
        return AppColor.appApricot;
      case AppThemeType.almond:
        return AppColor.appAlmond;
      case AppThemeType.ashGray:
        return AppColor.appAshGray;
      case AppThemeType.thistle:
        return AppColor.appThistle;
    }
  }
}
