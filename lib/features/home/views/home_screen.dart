import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';
import 'package:moodtracker/features/home/views/widgets/mood_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodModelStream = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return moodModelStream.when(
      data: (data) {
        return data.isEmpty
            ? const Center(
                child: Text("Write down how you feel!"),
              )
            : CustomScrollView(
                slivers: [
                  SliverList.separated(
                    separatorBuilder: (context, index) => const Gap(20),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MoodCard(
                        onTrashTap: () =>
                            _deleteMood(data[index], context, ref),
                        moodType: data[index].moodType,
                        createdAt: viewModel.formatDate(data[index].createdAt),
                        description: data[index].description,
                      );
                    },
                  ),
                ],
              );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _deleteMood(MoodModel mood, BuildContext context, WidgetRef ref) {
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
                        ref.read(homeProvider.notifier).deleteMood(mood);
                        context.pop();
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
