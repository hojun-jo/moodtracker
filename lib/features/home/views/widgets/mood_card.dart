import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';

class MoodCard extends StatelessWidget {
  final MoodType moodType;
  final String createdAt;
  final String description;

  const MoodCard({
    super.key,
    required this.moodType,
    required this.createdAt,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(
                  moodType.toIcon(),
                  size: 30,
                  color: moodType.toColor(),
                ),
                Text(
                  createdAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
