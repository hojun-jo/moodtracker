import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';

class WriteViewModel extends AutoDisposeNotifier {
  late final MoodRepository _moodRepository;

  @override
  void build() {
    _moodRepository = ref.read(moodRepository);
  }

  Future<void> post(
    MoodType mood,
    String description,
  ) async {
    await _moodRepository.addMood(MoodModel(
      id: Isar.autoIncrement,
      moodType: mood,
      description: description,
      createdAt: DateTime.now(),
    ));
  }
}

final writeProvider = NotifierProvider.autoDispose<WriteViewModel, void>(
  () => WriteViewModel(),
);
