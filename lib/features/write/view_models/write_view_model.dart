import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

class WriteViewModel extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> post(
    MoodType mood,
    String description,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {});
  }
}

final writeProvider = AsyncNotifierProvider.autoDispose<WriteViewModel, void>(
  () => WriteViewModel(),
);
