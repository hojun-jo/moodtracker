import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class ThemeViewModel extends AutoDisposeNotifier<AsyncValue<AppThemeType>> {
  @override
  AsyncValue<AppThemeType> build() {
    return ref.watch(themeRepository).when(
          data: (data) {
            return AsyncValue.data(data.theme);
          },
          error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
          loading: () => const AsyncValue.loading(),
        );
  }

  void selectTheme(AppThemeType theme) {
    ref.read(themeRepository.notifier).setTheme(theme);
  }
}
