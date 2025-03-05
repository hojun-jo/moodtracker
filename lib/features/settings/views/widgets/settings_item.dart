import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isShowTrailing;

  const SettingsItem({
    super.key,
    required this.onTap,
    required this.text,
    this.isShowTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: onTap,
        title: Text(text),
        trailing: isShowTrailing ? const Icon(Icons.chevron_right) : null,
      ),
    );
  }
}
