import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// TODO: di/provider
import 'package:moodtracker/core/infra/repositories/mood_repository_impl.dart';
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
      moodType: mood,
      description: description,
      createdAt: DateTime.now(),
    ));
  }
}

final writeProvider = NotifierProvider.autoDispose<WriteViewModel, void>(
  () => WriteViewModel(),
);
