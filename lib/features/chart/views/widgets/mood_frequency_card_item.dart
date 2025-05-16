import 'package:flutter/material.dart';

class MoodFrequencyCardItem extends StatelessWidget {
  static const double width = 66;

  final String moodAssetName;
  final int moodCount;

  const MoodFrequencyCardItem({
    super.key,
    required this.moodAssetName,
    required this.moodCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              moodAssetName,
              width: width,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$moodCount',
                  style: const TextStyle(height: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
