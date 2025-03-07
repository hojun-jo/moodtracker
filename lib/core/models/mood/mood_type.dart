import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/theme/app_color.dart';

enum MoodType {
  angry("angry"),
  blank("blank"),
  smile("smmile");

  final String text;

  const MoodType(this.text);

  factory MoodType.fromString(String text) {
    return values.firstWhere((e) => e.text == text);
  }

  IconData toIcon() {
    switch (this) {
      case MoodType.angry:
        return FontAwesomeIcons.faceAngry;
      case MoodType.blank:
        return FontAwesomeIcons.faceMehBlank;
      case MoodType.smile:
        return FontAwesomeIcons.faceSmile;
    }
  }

  Color toColor() {
    switch (this) {
      case MoodType.angry:
        return AppColor.red;
      case MoodType.blank:
        return AppColor.yellow;
      case MoodType.smile:
        return AppColor.green;
    }
  }
}
