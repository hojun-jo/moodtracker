import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.red,
                  value: 40,
                ),
                PieChartSectionData(
                  color: Colors.blue,
                  value: 30,
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 20,
                ),
                PieChartSectionData(
                  color: Colors.yellow,
                  value: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
