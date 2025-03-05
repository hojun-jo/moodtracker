import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final Widget child;

  const MoodCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: child,
    );
  }
}
