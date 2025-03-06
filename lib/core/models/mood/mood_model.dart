import 'package:moodtracker/core/models/mood/mood_type.dart';

class MoodModel {
  final String uid;
  final String id;
  final MoodType moodType;
  final String description;
  final DateTime createdAt;

  MoodModel({
    required this.uid,
    required this.id,
    required this.moodType,
    required this.description,
    required this.createdAt,
  });
}
