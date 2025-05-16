import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:moodtracker/core/models/mood/mood_category.dart';

class WriteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final MoodCategory moodCategory;
=======
import 'package:moodtracker/core/models/mood/mood_type.dart';

class WriteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final MoodType moodType;
>>>>>>> origin/main
  final bool isSelected;

  const WriteIconButton({
    super.key,
    required this.onTap,
<<<<<<< HEAD
    required this.moodCategory,
=======
    required this.moodType,
>>>>>>> origin/main
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              isSelected ? theme.scaffoldBackgroundColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
<<<<<<< HEAD
          moodCategory.assetName,
=======
          moodType.assetName,
>>>>>>> origin/main
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
