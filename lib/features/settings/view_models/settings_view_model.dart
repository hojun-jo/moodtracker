import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/repositories/interfaces/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class SettingsViewModel {
  final ThemeRepository themeRepo;

  SettingsViewModel({required this.themeRepo});

  AsyncValue<AppThemeType> getTheme(WidgetRef ref) {
    return ref.watch(themeRepository).when(
          data: (data) {
            return AsyncValue.data(data.theme);
          },
          error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
          loading: () => const AsyncValue.loading(),
        );
  }

  void selectTheme(AppThemeType theme) {
    themeRepo.setTheme(theme);
  }
}

final settingsProvider = Provider<SettingsViewModel>(
  (ref) => SettingsViewModel(
    themeRepo: ref.watch(themeRepository.notifier),
  ),
);
