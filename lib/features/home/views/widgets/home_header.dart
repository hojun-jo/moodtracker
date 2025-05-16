import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';
import 'package:moodtracker/features/home/provider/provider.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({super.key});

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateRange = ref.watch(homeDateRangeProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          SmallIconButton(
            onTap: () => _onDateChanged(context),
            icon: FontAwesomeIcons.filter,
          ),
          if (dateRange != null)
            SmallIconButton(
              onTap: _deleteFilter,
              icon: FontAwesomeIcons.filterCircleXmark,
            ),
        ],
      ),
    );
  }

  void _onDateChanged(BuildContext context) async {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final dateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: now, end: now),
      firstDate: DateTime(2020),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              headlineSmall: theme.textTheme.bodySmall,
            ),
          ),
          child: child!,
        );
      },
    );

    if (dateRange != null) {
      _changeDateRange(dateRange);
    }
  }

  void _deleteFilter() {
    _changeDateRange(null);
  }

  void _changeDateRange(DateTimeRange? dateRange) {
    ref.read(homeDateRangeProvider.notifier).state = dateRange;
  }
}
