import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/models/main_navigation/main_navigation_type.dart';
import 'package:moodtracker/core/widgets/main_navigation/main_navigation_bar_item.dart';

class MainNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: navigationShell,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...MainNavigationType.values.map((value) {
                return MainNavigationBarItem(
                  onTap: () => _navigateTo(value),
                  icon: value.toIcon(),
                  isSelected: navigationShell.currentIndex == value.toIndex(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(MainNavigationType value) {
    switch (value) {
      case MainNavigationType.home:
        navigationShell.goBranch(MainNavigationType.home.toIndex());
      case MainNavigationType.write:
        navigationShell.goBranch(MainNavigationType.write.toIndex());
      case MainNavigationType.settings:
        navigationShell.goBranch(MainNavigationType.settings.toIndex());
    }
  }
}
