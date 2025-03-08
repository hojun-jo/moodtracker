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
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
