import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';
import 'package:moodtracker/features/chart/views/widgets/mood_frequency_card.dart';
import 'package:moodtracker/features/chart/views/widgets/pie_chart_card.dart';
import 'package:moodtracker/features/chart/views/widgets/scatter_chart_card.dart';

class ChartScreen extends ConsumerStatefulWidget {
  const ChartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartScreenState();
}

class _ChartScreenState extends ConsumerState<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    final isChartSample = ref.watch(chartStateProvider).isChartSample;

    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          ValueListenableBuilder(
            valueListenable: isChartSample,
            builder: (context, value, child) {
              if (value) return const Text("Sample Data");
              return Container();
            },
          ),
          const PieChartCard(),
          const MoodFrequencyCard(),
          const ScatterChartCard(),
        ],
      ),
    );
  }
}
