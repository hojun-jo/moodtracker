import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';
import 'package:moodtracker/core/repos/mood_repository.dart';
import 'package:uuid/uuid.dart';

class WriteViewModel extends AutoDisposeAsyncNotifier {
  late final MoodRepository _writeRepository;

  @override
  FutureOr build() {
    _writeRepository = ref.read(moodRepo);
  }

  Future<void> post(
    MoodType mood,
    String description,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authRepo).user!;
      final moodModel = MoodModel(
        uid: user.uid,
        id: const Uuid().v4(),
        moodType: mood,
        description: description,
        createdAt: DateTime.now(),
      );

      await _writeRepository.postMood(moodModel.toJson());
    });
  }
}

final writeProvider = AsyncNotifierProvider.autoDispose<WriteViewModel, void>(
  () => WriteViewModel(),
);
