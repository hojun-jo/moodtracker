import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';

class HomeHeader extends StatefulWidget {
  final Function(DateTimeRange?) onDateChanged;

  const HomeHeader({
    super.key,
    required this.onDateChanged,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          SmallIconButton(
            onTap: () => _onDateChanged(context),
            icon: FontAwesomeIcons.filter,
          ),
          if (_selectedDateRange != null)
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
    widget.onDateChanged(dateRange);
    setState(() {
      _selectedDateRange = dateRange;
    });
  }
}
