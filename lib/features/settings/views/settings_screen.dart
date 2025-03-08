import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/settings/view_models/settings_view_model.dart';
import 'package:moodtracker/features/settings/views/widgets/settings_item.dart';
import 'package:moodtracker/route/route_path.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 8,
      children: [
        // TODO: app color select 구현
        SettingsItem(
          onTap: () {},
          text: "Theme",
        ),
        SettingsItem(
          onTap: () => showLicensePage(context: context),
          text: "Lisence",
          trailing: const Icon(Icons.chevron_right),
        ),

        SettingsItem(
          onTap: () => _signOut(context, ref),
          text: "Sign Out",
          textColor: Colors.red,
        ),
      ],
    );
  }

  void _signOut(
    BuildContext context,
    WidgetRef ref,
  ) {
    final viewModel = ref.read(settingsProvider.notifier);

    viewModel.signOut();
    context.go(RoutePath.signIn);
  }
}
