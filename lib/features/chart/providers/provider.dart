import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/features/chart/models/mood_category_count.dart';
import 'package:moodtracker/features/chart/models/scatter_model.dart';
import 'package:moodtracker/features/chart/repositories/chart_date_range_repository.dart';
import 'package:moodtracker/features/chart/repositories/chart_state_repository.dart';
import 'package:moodtracker/features/chart/repositories/sample_chart_repository.dart';
import 'package:moodtracker/features/chart/view_models/mood_frequency_view_model.dart';
import 'package:moodtracker/features/chart/view_models/pie_chart_view_model.dart';
import 'package:moodtracker/features/chart/view_models/scatter_chart_view_model.dart';

// chart date range

final chartDateRangeProvider =
    NotifierProvider<ChartDateRangeRepository, DateTimeRange>(
  () => ChartDateRangeRepository(),
);

// view model

final pieChartProvider = NotifierProvider.autoDispose<PieChartViewModel,
    AsyncValue<List<PieChartSectionData>>>(
  () => PieChartViewModel(),
);

final moodFrequencyProvider = NotifierProvider.autoDispose<
    MoodFrequencyViewModel, AsyncValue<List<MoodCategoryCount>>>(
  () => MoodFrequencyViewModel(),
);

final scatterChartProvider = NotifierProvider.autoDispose<ScatterChartViewModel,
    AsyncValue<List<ScatterModel>>>(
  () => ScatterChartViewModel(),
);

// repository

final sampleChartProvider =
    AsyncNotifierProvider.autoDispose<SampleChartRepository, List<MoodModel>>(
  () => SampleChartRepository(),
);

final chartStateProvider = Provider(
  (ref) => ChartStateRepository(),
);
