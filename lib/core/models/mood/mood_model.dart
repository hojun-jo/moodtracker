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

  // factory MoodModel.fromJson(Map<String, dynamic> json) {
  //   return MoodModel(
  //     uid: json["uid"],
  //     id: json["id"],
  //     moodType: MoodType.fromString(json["moodType"]),
  //     description: json["description"],
  //     createdAt: (json["createdAt"] as Timestamp).toDate(),
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "id": id,
      "moodType": moodType.text,
      "description": description,
      "createdAt": createdAt,
    };
  }
}
