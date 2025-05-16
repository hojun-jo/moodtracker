import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
<<<<<<< HEAD
import 'package:moodtracker/features/home/provider/provider.dart';
=======
import 'package:moodtracker/features/home/view_models/home_view_model.dart';
>>>>>>> origin/main
import 'package:moodtracker/features/home/views/widgets/home_header_delegate.dart';
import 'package:moodtracker/features/home/views/widgets/mood_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
<<<<<<< HEAD
  late final _viewModel = ref.read(homeProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final moodModelStream = ref.watch(homeProvider);
=======
  late final HomeViewModel _viewModel =
      ref.read(homeProvider(_selectedDate).notifier);

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final moodModelStream = ref.watch(homeProvider(_selectedDate));
>>>>>>> origin/main

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
<<<<<<< HEAD
          pinned: true,
          floating: true,
          delegate: HomeHeaderDelegate(),
=======
          delegate: HomeHeaderDelegate(
            onDateChanged: _onDateChanged,
          ),
>>>>>>> origin/main
        ),
        moodModelStream.when(
          data: (data) {
            return data.isEmpty
                ? SliverToBoxAdapter(
                    child: CenterText(text: "Write down how you feel!".tr()),
                  )
                : SliverList.separated(
<<<<<<< HEAD
                    separatorBuilder: (context, index) => const Gap(16),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MoodCard(
                        moodType: data[index].moodCategory,
=======
                    separatorBuilder: (context, index) => const Gap(20),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MoodCard(
                        moodType: data[index].moodType,
>>>>>>> origin/main
                        createdAt: _viewModel.formatDate(data[index].createdAt),
                        description: data[index].description,
                      );
                    },
                  );
          },
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
<<<<<<< HEAD
              child: CenterText(text: error.toString()),
            );
          },
          loading: () {
            return const SliverToBoxAdapter(
              child: CenterProgressIndicator(),
            );
=======
                child: CenterText(text: error.toString()));
          },
          loading: () {
            return const SliverToBoxAdapter(child: CenterProgressIndicator());
>>>>>>> origin/main
          },
        ),
      ],
    );
<<<<<<< HEAD
=======
  }

  void _onDateChanged(DateTime? date) {
    _selectedDate = date;
    setState(() {});
>>>>>>> origin/main
  }
}
