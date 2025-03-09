import 'package:flutter/material.dart';

class ThemeMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;

  const ThemeMenuItem({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          spacing: 8,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
