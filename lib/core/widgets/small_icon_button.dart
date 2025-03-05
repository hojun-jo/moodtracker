import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const SmallIconButton({
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
        size: 16,
      ),
    );
  }
}
