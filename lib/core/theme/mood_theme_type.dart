import 'dart:ui';

import 'package:moodtracker/core/theme/mood_color.dart';

enum MoodThemeType {
  red,
  orange,
  white,
  green,
  purple;

  Color toColor() {
    switch (this) {
      case MoodThemeType.red:
        return MoodColor.appRed;
      case MoodThemeType.orange:
        return MoodColor.appOrange;
      case MoodThemeType.white:
        return MoodColor.appWhite;
      case MoodThemeType.green:
        return MoodColor.appGreen;
      case MoodThemeType.purple:
        return MoodColor.appPurple;
    }
  }
}
