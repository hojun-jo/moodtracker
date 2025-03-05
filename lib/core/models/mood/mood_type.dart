import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MoodType {
  angry,
  blank,
  smile;

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
}
