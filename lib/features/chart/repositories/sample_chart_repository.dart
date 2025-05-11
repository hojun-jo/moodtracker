import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

class SampleChartRepository extends AutoDisposeAsyncNotifier<List<MoodModel>> {
  @override
  FutureOr<List<MoodModel>> build() async {
    List<MoodModel> samples = [];
    final json = await _getSampleJson();

    for (final model in json) {
      samples.add(MoodModel(
        id: model["id"],
        moodType: _getMoodType(model["moodType"]),
        description: model["description"],
        createdAt: DateTime.fromMicrosecondsSinceEpoch(model["createdAt"]),
      ));
    }

    return samples;
  }

  Future<List<dynamic>> _getSampleJson() async {
    final jsonString =
        await rootBundle.loadString("assets/samples/sample_mood_ko.json");

    return json.decode(jsonString);
  }

  MoodType _getMoodType(int index) {
    switch (index) {
      case 0:
        return MoodType.angry;
      case 1:
        return MoodType.anxiety;
      case 2:
        return MoodType.calm;
      case 3:
        return MoodType.excitement;
      case 4:
        return MoodType.happy;
      case 5:
        return MoodType.joy;
      case 6:
        return MoodType.neutral;
      case 7:
        return MoodType.sad;
      default:
        return MoodType.angry;
    }
  }
}
