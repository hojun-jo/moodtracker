import 'package:flutter/material.dart';

class WriteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const WriteIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 36,
      ),
    );
  }
}
