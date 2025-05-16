import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/chart/provider/provider.dart';
import 'package:moodtracker/features/chart/views/widgets/mood_frequency_card_item.dart';

class MoodFrequencyCard extends ConsumerWidget {
  const MoodFrequencyCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodFrequency = ref.watch(moodFrequencyProvider);

    return moodFrequency.when(
      data: (data) {
        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...data.map((moodTypeCount) {
                  return MoodFrequencyCardItem(
                    moodAssetName: moodTypeCount.category.assetName,
                    moodCount: moodTypeCount.count,
                  );
                }),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => CenterText(text: error.toString()),
      loading: () => const CenterProgressIndicator(),
    );
  }
}
