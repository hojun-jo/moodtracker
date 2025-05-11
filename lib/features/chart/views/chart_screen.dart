import 'package:flutter/material.dart';
import 'package:moodtracker/features/chart/views/widgets/mood_frequency_card.dart';
import 'package:moodtracker/features/chart/views/widgets/pie_chart_card.dart';
import 'package:moodtracker/features/chart/views/widgets/scatter_chart_card.dart';

// TODO: 데이터가 없을 때 더미 데이터로 표시
class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          PieChartCard(),
          MoodFrequencyCard(),
          ScatterChartCard(),
        ],
      ),
    );
  }
}
