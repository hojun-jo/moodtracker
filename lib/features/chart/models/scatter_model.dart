import 'package:moodtracker/core/models/mood/mood_type.dart';

class ScatterModel {
  final int hour;
  final MoodType type;
  final int count;

  ScatterModel({
    required this.hour,
    required this.type,
    required this.count,
  });
}
