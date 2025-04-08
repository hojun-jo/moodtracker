import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/core/widgets/error_dialog.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';
import 'package:moodtracker/features/home/views/widgets/mood_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final HomeViewModel _viewModel =
      ref.read(homeProvider(_selectedDate).notifier);

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final moodModelStream = ref.watch(homeProvider(_selectedDate));

    return moodModelStream.when(
      data: (data) {
        return data.isEmpty
            ? const CenterText(text: "Write down how you feel!")
            : CustomScrollView(
                slivers: [
                  SliverList.separated(
                    separatorBuilder: (context, index) => const Gap(20),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MoodCard(
                        onTrashTap: () => _showDeleteMoodDialog(data[index]),
                        moodType: data[index].moodType,
                        createdAt: _viewModel.formatDate(data[index].createdAt),
                        description: data[index].description,
                      );
                    },
                  ),
                ],
              );
      },
      error: (error, stackTrace) {
        return CenterText(text: error.toString());
      },
      loading: () {
        return const CenterProgressIndicator();
      },
    );
  }

  void _showDeleteMoodDialog(MoodModel mood) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 200,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Confirm Delete?"),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        try {
                          _viewModel.deleteMood(mood);
                          context.pop();
                        } catch (e) {
                          context.pop();
                          showErrorDialog(
                            context: context,
                            text: e.toString(),
                          );
                        }
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
