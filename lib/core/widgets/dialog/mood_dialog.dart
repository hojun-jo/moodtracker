import 'package:flutter/material.dart';

class MoodDialog extends StatelessWidget {
  final String title;
  final String confirmText;
  final String cancelText;
  final Color? confirmColor;
  final Color? cancelColor;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const MoodDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
    this.confirmColor,
    this.cancelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      color: confirmColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onCancel,
                  child: Text(
                    cancelText,
                    style: TextStyle(
                      color: cancelColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showMoodDialog({
  required BuildContext context,
  required String title,
  required String confirmText,
  required String cancelText,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  Color? confirmColor,
  Color? cancelColor,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return MoodDialog(
        title: title,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmColor: confirmColor,
        cancelColor: cancelColor,
      );
    },
  );
}
