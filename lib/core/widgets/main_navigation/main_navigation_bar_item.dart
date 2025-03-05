import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/theme/mood_color.dart';

class MainNavigationBarItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool isSelected;

  const MainNavigationBarItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FaIcon(
        icon,
        color: isSelected ? MoodColor.darkgrey : MoodColor.grey,
      ),
    );
  }
}
