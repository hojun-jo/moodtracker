import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';

class WriteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final MoodCategory moodCategory;
  final bool isSelected;

  const WriteIconButton({
    super.key,
    required this.onTap,
    required this.moodCategory,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.2 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected ? theme.scaffoldBackgroundColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            moodCategory.assetName,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}
