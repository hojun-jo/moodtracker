import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/theme/app_color.dart';

class ScatterChartLegend extends StatelessWidget {
  final MoodType moodType;

  const ScatterChartLegend({
    super.key,
    required this.moodType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundColor: moodType.color,
          radius: 10,
        ),
        Text(
          moodType.text.tr(),
          style: textTheme.bodySmall!.copyWith(color: AppColor.black),
        ),
        ...MoodCategory.values.where((e) => e.type == moodType).map((e) {
          return Image.asset(
            e.assetName,
            width: 24,
          );
        }),
      ],
    );
  }
}
