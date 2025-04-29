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
}
