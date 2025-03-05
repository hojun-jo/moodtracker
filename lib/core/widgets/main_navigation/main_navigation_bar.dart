import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/constants/app_route.dart';
import 'package:moodtracker/core/models/main_navigation/main_navigation_type.dart';
import 'package:moodtracker/core/widgets/main_navigation/main_navigation_bar_item.dart';

class MainNavigationBar extends StatefulWidget {
  final Widget child;

  const MainNavigationBar({
    super.key,
    required this.child,
  });

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...MainNavigationType.values.map((value) {
                return MainNavigationBarItem(
                  onTap: () => _selecteTap(value),
                  icon: value.toIcon(),
                  isSelected: _currentIndex == value.toIndex(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _selecteTap(MainNavigationType value) {
    _currentIndex = value.toIndex();
    _navigate(value);
    setState(() {});
  }

  void _navigate(MainNavigationType value) {
    switch (value) {
      case MainNavigationType.home:
        context.go(AppRoute.home);
      case MainNavigationType.write:
        context.go(AppRoute.write);
      case MainNavigationType.settings:
        context.go(AppRoute.settings);
    }
  }
}
