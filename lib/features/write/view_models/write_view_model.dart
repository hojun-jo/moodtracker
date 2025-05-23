import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/core/repositories/interfaces/mood_repository.dart';

class WriteViewModel extends AutoDisposeNotifier {
  late final MoodRepository _moodRepository;

  @override
  void build() {
    _moodRepository = ref.read(moodRepository(null).notifier);
  }

  Future<void> post(
    MoodCategory mood,
    String description,
  ) async {
    await _moodRepository.addMood(mood, description);
  }
}

final writeProvider = NotifierProvider.autoDispose<WriteViewModel, void>(
  () => WriteViewModel(),
);
