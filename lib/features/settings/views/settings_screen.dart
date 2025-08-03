import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/core/widgets/dialog/error_dialog.dart';
import 'package:moodtracker/core/widgets/dialog/mood_dialog.dart';
import 'package:moodtracker/features/settings/providers/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationProvider);

    return Column(
      spacing: 16,
      children: [
        SettingsItem(
          onTap: () {},
          text: "Theme".tr(),
          trailing: ref.watch(themeProvider).when(
            data: (currentTheme) {
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
                    color: currentTheme.toColor(),
                    text: currentTheme.text,
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () {
              return const CenterProgressIndicator();
            },
          ),
        ),
        if (context.locale.languageCode != "ja")
          SettingsItem(
            onTap: () {
              context.push(RoutePath.fonts);
            },
            text: "Fonts",
            trailing: const Icon(Icons.chevron_right),
          ),
        SettingsItem(
          onTap: () => showLicensePage(context: context),
          text: "Open Source Lisence".tr(),
          trailing: const Icon(Icons.chevron_right),
        ),
        authState.when(
          data: (isLoggedIn) {
            if (isLoggedIn) {
              return Column(
                spacing: 16,
                children: [
                  SettingsItem(
                    onTap: _signOut,
                    text: "Sign out",
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  SettingsItem(
                    onTap: _deleteAccount,
                    text: "Delete account",
                    textColor: Colors.red,
                  ),
                ],
              );
            } else {
              return SettingsItem(
                onTap: () => context.push(RoutePath.signIn),
                text: "Sign in",
                trailing: const Icon(Icons.chevron_right),
              );
            }
          },
          error: (Object error, StackTrace stackTrace) =>
              CenterText(text: error.toString()),
          loading: () => const CenterProgressIndicator(),
        ),
      ],
    );
  }

  void _selectTheme(AppThemeType theme) {
    try {
      ref.read(themeProvider.notifier).selectTheme(theme);
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

  void _signOut() {
    try {
      ref.read(authenticationProvider.notifier).signOut();
    } catch (e) {
      showErrorDialog(
        context: context,
        text: e.toString(),
      );
    }
  }

  void _deleteAccount() {
    showMoodDialog(
      context: context,
      title: "delete account alert".tr(),
      confirmText: "delete".tr(),
      cancelText: "cancel".tr(),
      onConfirm: () {
        try {
          ref.read(authenticationProvider.notifier).deleteAccount();
        } catch (e) {
          showErrorDialog(
            context: context,
            text: e.toString(),
          );
        }
      },
      onCancel: () => context.pop(),
      confirmColor: Colors.red,
    );
  }
}
