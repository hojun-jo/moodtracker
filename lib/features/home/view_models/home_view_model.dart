import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/repositories/mood_repository.dart';
import 'package:moodtracker/core/utils/date_formater.dart';

class HomeViewModel
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, DateTimeRange?> {
  late final MoodRepository _moodRepository;

  @override
  Stream<List<MoodModel>> build(DateTimeRange? dateRange) {
    _moodRepository = ref.read(moodRepository);

    return _moodRepository.watchMoods(dateRange: dateRange);
  }

  String formatDate(DateTime date) {
    return DateFormater.formatMoodCard(date);
  }
}

final homeProvider = StreamNotifierProvider.autoDispose
    .family<HomeViewModel, List<MoodModel>, DateTimeRange?>(
  () => HomeViewModel(),
);
