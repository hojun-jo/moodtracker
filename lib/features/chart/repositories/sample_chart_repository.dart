import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/core/utils/file_loader.dart';

class SampleChartRepository extends AutoDisposeAsyncNotifier<List<MoodModel>> {
  final FileLoader _fileLoader;
  final String _filePath;

  SampleChartRepository({
    FileLoader? fileLoader,
    String? filePath,
  })  : _fileLoader = fileLoader ?? AssetFileLoader(),
        _filePath = filePath ?? "assets/samples/sample_mood_ko.json";

  @override
  FutureOr<List<MoodModel>> build() async {
    List<MoodModel> samples = [];
    final json = await _getSampleJson();

    for (final model in json) {
      samples.add(MoodModel(
        id: model["id"],
        moodCategory: _getMoodType(model["moodType"]),
        description: model["description"],
        createdAt: DateTime.fromMicrosecondsSinceEpoch(model["createdAt"]),
      ));
    }

    return samples;
  }

  Future<List<dynamic>> _getSampleJson() async {
    try {
      final jsonString = await _fileLoader.loadString(_filePath);
      return json.decode(jsonString);
    } catch (e) {
      if (e is FormatException) {
        rethrow;
      }
      throw Exception('Failed to load sample file: $e');
    }
  }

  MoodCategory _getMoodType(int index) {
    switch (index) {
      case 0:
        return MoodCategory.angry;
      case 1:
        return MoodCategory.anxiety;
      case 2:
        return MoodCategory.calm;
      case 3:
        return MoodCategory.excitement;
      case 4:
        return MoodCategory.happy;
      case 5:
        return MoodCategory.joy;
      case 6:
        return MoodCategory.neutral;
      case 7:
        return MoodCategory.sad;
      default:
        throw Exception("Invalid mood type from sample data.");
    }
  }
}
