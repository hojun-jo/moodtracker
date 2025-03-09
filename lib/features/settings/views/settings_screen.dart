import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/providers/theme_provider.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/core/widgets/error_dialog.dart';
import 'package:moodtracker/features/settings/view_models/settings_view_model.dart';
import 'package:moodtracker/features/settings/views/widgets/settings_item.dart';
import 'package:moodtracker/features/settings/views/widgets/theme_menu_item.dart';
import 'package:moodtracker/route/route_path.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final MenuController _menuController = MenuController();
  late final SettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(settingsProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Column(
      spacing: 8,
      children: [
        SettingsItem(
          onTap: () {},
          text: "Theme",
          trailing: MenuAnchor(
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
              return theme.when(
                data: (data) {
                  return ThemeMenuItem(
                    onTap: _onTapMenu,
                    color: data.toColor(),
                    text: data.text,
                  );
                },
                error: (error, stackTrace) {
                  return CenterText(text: error.toString());
                },
                loading: () {
                  return const CenterProgressIndicator();
                },
              );
            },
          ),
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

  void _selectTheme(AppThemeType theme) {
    try {
      ref.read(themeProvider.notifier).setTheme(theme);
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

  void _signOut(
    BuildContext context,
    WidgetRef ref,
  ) {
    try {
      _viewModel.signOut();
      context.go(RoutePath.signIn);
    } catch (e) {
      showErrorDialog(
        context: context,
        text: e.toString(),
      );
    }
  }
}
