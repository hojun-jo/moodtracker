import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

class MoodCard extends StatelessWidget {
  final MoodCategory moodType;
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
                Image.asset(
                  moodType.assetName,
                  width: 50,
                  height: 50,
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
