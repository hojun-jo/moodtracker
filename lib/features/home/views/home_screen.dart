import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/home/view_models/home_view_model.dart';
import 'package:moodtracker/features/home/views/widgets/home_header_delegate.dart';
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

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: HomeHeaderDelegate(
            onDateChanged: _onDateChanged,
          ),
        ),
        moodModelStream.when(
          data: (data) {
            return data.isEmpty
                ? const SliverToBoxAdapter(
                    child: CenterText(text: "Write down how you feel!"),
                  )
                : SliverList.separated(
                    separatorBuilder: (context, index) => const Gap(20),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MoodCard(
                        moodType: data[index].moodType,
                        createdAt: _viewModel.formatDate(data[index].createdAt),
                        description: data[index].description,
                      );
                    },
                  );
          },
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
                child: CenterText(text: error.toString()));
          },
          loading: () {
            return const SliverToBoxAdapter(child: CenterProgressIndicator());
          },
        ),
      ],
    );
  }

  void _onDateChanged(DateTime? date) {
    _selectedDate = date;
    setState(() {});
  }
}
