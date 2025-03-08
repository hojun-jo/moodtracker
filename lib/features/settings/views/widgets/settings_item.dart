import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? textColor;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 4,
          ),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
