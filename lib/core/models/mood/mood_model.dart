import 'package:isar/isar.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

part 'mood_model.g.dart';

@collection
class MoodModel {
  final Id id;
  @enumerated
  final MoodType moodType;
  final String description;
  final DateTime createdAt;

  MoodModel({
    required this.id,
    required this.moodType,
    required this.description,
    required this.createdAt,
  });
}
