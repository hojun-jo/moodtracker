import 'dart:ui';

import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/theme/app_color.dart';

enum MoodCategory {
  excitement,
  joy,
  happy,
  calm,
  neutral,
  anxiety,
  sad,
  angry;

  static const _properties = {
    MoodCategory.excitement: (
      text: "excitement",
      asset: "assets/icons/excitement.png",
      color: AppColor.excitement,
      type: MoodType.positive,
    ),
    MoodCategory.joy: (
      text: "joy",
      asset: "assets/icons/joy.png",
      color: AppColor.joy,
      type: MoodType.positive,
    ),
    MoodCategory.happy: (
      text: "happy",
      asset: "assets/icons/happy.png",
      color: AppColor.happy,
      type: MoodType.positive,
    ),
    MoodCategory.calm: (
      text: "calm",
      asset: "assets/icons/calm.png",
      color: AppColor.calm,
      type: MoodType.neutrality,
    ),
    MoodCategory.neutral: (
      text: "neutral",
      asset: "assets/icons/neutral.png",
      color: AppColor.neutral,
      type: MoodType.neutrality,
    ),
    MoodCategory.anxiety: (
      text: "anxiety",
      asset: "assets/icons/anxiety.png",
      color: AppColor.anxiety,
      type: MoodType.negative,
    ),
    MoodCategory.sad: (
      text: "sad",
      asset: "assets/icons/sad.png",
      color: AppColor.sad,
      type: MoodType.negative,
    ),
    MoodCategory.angry: (
      text: "angry",
      asset: "assets/icons/angry.png",
      color: AppColor.angry,
      type: MoodType.negative,
    ),
  };

  factory MoodCategory.fromString(String text) {
    return _properties.entries
        .where((e) => e.value.text == text)
        .map((e) => e.key)
        .first;
  }

  factory MoodCategory.fromIndex(int index) {
    return MoodCategory.values.firstWhere((e) => (e.index == index));
  }

  String get assetName => _properties[this]!.asset;

  Color get color => _properties[this]!.color;

  MoodType get type => _properties[this]!.type;
}
