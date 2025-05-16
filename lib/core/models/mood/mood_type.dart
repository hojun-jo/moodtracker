import 'package:flutter/material.dart';

enum MoodType {
  positive,
  neutrality,
  negative;

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

  String get text => _properties[this]!.text;
}
