import 'package:flutter/material.dart';
import 'package:moodtracker/features/settings/views/widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        // TODO: app color select 구현
        SettingsItem(
          onTap: () {},
          text: "Theme",
        ),
        // TODO: lisence 페이지 구현
        SettingsItem(
          onTap: () {},
          text: "Lisence",
        ),
        // TODO: logout 구현
        SettingsItem(
          onTap: () {},
          text: "Logout",
          isShowTrailing: false,
        ),
      ],
    );
  }
}
