import 'package:cloud_firestore/cloud_firestore.dart';

class MoodModelDto {
  final String uid;
  final String id;
  final String moodType;
  final String description;
  final DateTime createdAt;

  MoodModelDto({
    required this.uid,
    required this.id,
    required this.moodType,
    required this.description,
    required this.createdAt,
  });

  MoodModelDto.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        id = json["id"],
        moodType = json["moodType"],
        description = json["description"],
        createdAt = (json["createdAt"] as Timestamp).toDate();
}
