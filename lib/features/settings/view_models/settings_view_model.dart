import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/repositories/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class SettingsViewModel {
  final ThemeRepository themeRepository;

  SettingsViewModel({required this.themeRepository});
// TODO: AsyncValue로 변경
  Future<AppThemeType> get theme => themeRepository.getTheme();

  void selectTheme(AppThemeType theme) {
    themeRepository.setTheme(theme);
  }
}

final settingsProvider = Provider<SettingsViewModel>(
  (ref) => SettingsViewModel(
    themeRepository: ref.watch(themeRepository.notifier),
  ),
);
