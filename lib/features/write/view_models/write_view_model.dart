import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/providers/user_notifier.dart';
import 'package:moodtracker/features/write/repos/write_repository.dart';
import 'package:uuid/uuid.dart';

class WriteViewModel extends AsyncNotifier {
  late final WriteRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(writeRepo);
  }

  Future<void> post(MoodType mood, String description) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(userProvider).value!;
      final moodModel = MoodModel(
        uid: user.uid,
        id: const Uuid().v4(),
        moodType: mood,
        description: description,
        createdAt: DateTime.now(),
      );

      await _repository.post(moodModel);
    });
  }
}

final writeProvider = AsyncNotifierProvider<WriteViewModel, void>(
  () => WriteViewModel(),
);
