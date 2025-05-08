import 'dart:ui';

import 'package:moodtracker/core/theme/app_color.dart';

enum MoodType {
  angry("angry"),
  anxiety("anxiety"),
  calm("calm"),
  excitement("excitement"),
  happy("happy"),
  joy("joy"),
  neutral("neutral"),
  sad("sad");

  final String text;

  const MoodType(this.text);

  factory MoodType.fromString(String text) {
    return values.firstWhere((e) => e.text == text);
  }

  String get assetName {
    switch (this) {
      case MoodType.angry:
        return "assets/icons/angry.png";
      case MoodType.anxiety:
        return "assets/icons/anxiety.png";
      case MoodType.calm:
        return "assets/icons/calm.png";
      case MoodType.excitement:
        return "assets/icons/excitement.png";
      case MoodType.happy:
        return "assets/icons/happy.png";
      case MoodType.joy:
        return "assets/icons/joy.png";
      case MoodType.neutral:
        return "assets/icons/neutral.png";
      case MoodType.sad:
        return "assets/icons/sad.png";
    }
  }

  Color get color {
    switch (this) {
      case MoodType.angry:
        return AppColor.angry;
      case MoodType.anxiety:
        return AppColor.anxiety;
      case MoodType.calm:
        return AppColor.calm;
      case MoodType.excitement:
        return AppColor.excitement;
      case MoodType.happy:
        return AppColor.happy;
      case MoodType.joy:
        return AppColor.joy;
      case MoodType.neutral:
        return AppColor.neutral;
      case MoodType.sad:
        return AppColor.sad;
    }
  }

  double get scatterY {
    switch (this) {
      case MoodType.angry:
        return 1;
      case MoodType.anxiety:
        return 2;
      case MoodType.calm:
        return 3;
      case MoodType.excitement:
        return 4;
      case MoodType.happy:
        return 5;
      case MoodType.joy:
        return 6;
      case MoodType.neutral:
        return 7;
      case MoodType.sad:
        return 8;
    }
  }
}
