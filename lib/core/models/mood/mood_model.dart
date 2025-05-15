import 'package:isar/isar.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

part 'mood_model.g.dart';

@collection
class MoodModel {
  final Id id;
  @enumerated
  final MoodCategory moodCategory;
  final String description;
  final DateTime createdAt;

  MoodModel({
    required this.id,
    required this.moodCategory,
    required this.description,
    required this.createdAt,
  });
}
