import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';

class HomeHeader extends StatefulWidget {
  final Function(DateTime?) onDateChanged;

  const HomeHeader({
    super.key,
    required this.onDateChanged,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  DateTime? _selectedDate;

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
          if (_selectedDate != null)
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
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      currentDate: _selectedDate,
      builder: (context, child) => Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: theme.scaffoldBackgroundColor,
            onPrimary: theme.textTheme.bodyMedium?.color,
          ),
        ),
        child: child!,
      ),
    );

    if (date != null) {
      _changeDate(date);
    }
  }

  void _deleteFilter() {
    _changeDate(null);
  }

  void _changeDate(DateTime? date) {
    widget.onDateChanged(date);
    setState(() {
      _selectedDate = date;
    });
  }
}
