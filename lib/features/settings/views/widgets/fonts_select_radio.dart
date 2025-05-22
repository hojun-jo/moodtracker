import 'package:flutter/material.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';

class FontsSelectRadio extends StatelessWidget {
  final AppFontsType type;
  final AppFontsType currentValue;
  final Function(AppFontsType) onChanged;

  const FontsSelectRadio({
    super.key,
    required this.type,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type.text,
          style: type.style,
        ),
        Radio(
          value: type,
          groupValue: currentValue,
          onChanged: (value) => onChanged(value!),
        ),
      ],
    );
  }
}
