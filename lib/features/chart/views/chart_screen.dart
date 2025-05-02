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
        ...MoodType.values.map(
          (mood) => Container(
            height: 50,
            color: mood.color,
            child: Center(
              child: Text(
                mood.name,
              ),
            ),
          ),
        )
      ],
    );
  }
}
