import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';

class MoodCard extends StatelessWidget {
  final VoidCallback onTrashTap;
  final MoodType moodType;
  final String createdAt;
  final String description;

  const MoodCard({
    super.key,
    required this.onTrashTap,
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
                ),
                Text(
                  createdAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                SmallIconButton(
                  onTap: onTrashTap,
                  icon: FontAwesomeIcons.trashCan,
                ),
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
