import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text(text),
    );
  }
}

void showErrorDialog({
  required BuildContext context,
  required String text,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ErrorDialog(text: text);
    },
  );
}
