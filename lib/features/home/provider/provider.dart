import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';

// home date range

final homeDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

// view model

final homeProvider =
    NotifierProvider.autoDispose<HomeViewModel, AsyncValue<List<MoodModel>>>(
  () => HomeViewModel(),
);
