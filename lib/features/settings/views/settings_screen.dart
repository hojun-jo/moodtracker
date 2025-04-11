import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/dialog/error_dialog.dart';
import 'package:moodtracker/features/settings/view_models/settings_view_model.dart';
import 'package:moodtracker/features/settings/views/widgets/settings_item.dart';
import 'package:moodtracker/features/settings/views/widgets/theme_menu_item.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final MenuController _menuController = MenuController();
  late final SettingsViewModel _viewModel = ref.read(settingsProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SettingsItem(
          onTap: () {},
          text: "Theme",
          trailing: FutureBuilder(
            future: _viewModel.theme,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CenterProgressIndicator();
              }

              final theme = snapshot.data!;

              return MenuAnchor(
                controller: _menuController,
                menuChildren: [
                  ...AppThemeType.values.map((theme) {
                    return ThemeMenuItem(
                      onTap: () => _selectTheme(theme),
                      color: theme.toColor(),
                      text: theme.text,
                    );
                  }),
                ],
                builder: (
                  BuildContext context,
                  MenuController controller,
                  Widget? child,
                ) {
                  return ThemeMenuItem(
                    onTap: _onTapMenu,
                    color: theme.toColor(),
                    text: theme.text,
                  );
                },
              );
            },
          ),
        ),
        SettingsItem(
          onTap: () => showLicensePage(context: context),
          text: "Open Source Lisence",
          trailing: const Icon(Icons.chevron_right),
        ),
        // SettingsItem(
        //   onTap: _signOut,
        //   text: "Sign Out",
        //   textColor: Colors.red,
        // ),
      ],
    );
  }

  void _selectTheme(AppThemeType theme) {
    try {
      _viewModel.selectTheme(theme);
    } catch (e) {
      showErrorDialog(
        context: context,
        text: e.toString(),
      );
    }
    _menuController.close();
  }

  void _onTapMenu() {
    if (_menuController.isOpen) {
      _menuController.close();
    } else {
      _menuController.open();
    }
  }

  // void _signOut() {
  //   try {
  //     _viewModel.signOut();
  //     context.go(RoutePath.signIn);
  //   } catch (e) {
  //     showErrorDialog(
  //       context: context,
  //       text: e.toString(),
  //     );
  //   }
  // }
}
