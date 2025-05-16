<<<<<<< HEAD
import 'package:flutter/material.dart';

enum MoodType {
  positive,
  neutrality,
  negative;
=======
enum MoodType {
  angry("angry"),
  anxiety("anxiety"),
  calm("calm"),
  excitement("excitement"),
  happy("happy"),
  joy("joy"),
  neutral("neutral"),
  sad("sad");
>>>>>>> origin/main

  static const _properties = {
    MoodType.positive: (
      scatterY: 3.0,
      color: Colors.green,
      text: "positive",
    ),
    MoodType.neutrality: (
      scatterY: 2.0,
      color: Colors.blue,
      text: "neutrality",
    ),
    MoodType.negative: (
      scatterY: 1.0,
      color: Colors.red,
      text: "negative",
    ),
  };

  double get scatterY => _properties[this]!.scatterY;

  Color get color => _properties[this]!.color;

<<<<<<< HEAD
  String get text => _properties[this]!.text;
=======
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
>>>>>>> origin/main
}
