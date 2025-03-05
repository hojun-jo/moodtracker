import 'package:flutter/material.dart';
import 'package:moodtracker/features/settings/views/widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SettingsItem(
          onTap: () {},
          text: "Theme",
        ),
        SettingsItem(
          onTap: () {},
          text: "Lisence",
        ),
        SettingsItem(
          onTap: () {},
          text: "Logout",
          isShowTrailing: false,
        ),
      ],
    );
  }
}
