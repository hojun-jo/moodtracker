import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/chart/models/mood_type_count.dart';
import 'package:moodtracker/features/chart/models/scatter_model.dart';
import 'package:moodtracker/features/chart/view_models/mood_frequency_view_model.dart';
import 'package:moodtracker/features/chart/view_models/pie_chart_view_model.dart';
import 'package:moodtracker/features/chart/view_models/scatter_chart_view_model.dart';

// chart date range

final chartDateRangeProvider = StateProvider((ref) {
  final now = DateTime.now();

  return DateTimeRange(
    start: DateTime(now.year, now.month - 1),
    end: now,
  );
});

// view model

final pieChartProvider = NotifierProvider.autoDispose<PieChartViewModel,
    AsyncValue<List<PieChartSectionData>>>(
  () => PieChartViewModel(),
);

final moodFrequencyProvider = NotifierProvider.autoDispose<
    MoodFrequencyViewModel, AsyncValue<List<MoodTypeCount>>>(
  () => MoodFrequencyViewModel(),
);

final scatterChartProvider = NotifierProvider.autoDispose<ScatterChartViewModel,
    AsyncValue<List<ScatterModel>>>(
  () => ScatterChartViewModel(),
);
