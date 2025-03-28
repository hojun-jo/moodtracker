import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;

  const CenterText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
