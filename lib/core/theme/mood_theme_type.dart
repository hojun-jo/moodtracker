import 'dart:ui';

import 'package:moodtracker/core/theme/mood_color.dart';

enum MoodThemeType {
  red,
  white,
  green,
  blue,
  purple;

  Color toColor() {
    switch (this) {
      case MoodThemeType.red:
        return MoodColor.appRed;
      case MoodThemeType.white:
        return MoodColor.appWhite;
      case MoodThemeType.green:
        return MoodColor.appGreen;
      case MoodThemeType.blue:
        return MoodColor.appBlue;
      case MoodThemeType.purple:
        return MoodColor.appPurple;
    }
  }
}
