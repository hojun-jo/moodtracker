import 'package:flutter/material.dart';

class WriteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final bool isSelected;

  const WriteIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 36,
        color: isSelected ? color : null,
      ),
    );
  }
}
