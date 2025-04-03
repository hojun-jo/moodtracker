import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/repositories/theme_repository.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';

class SettingsViewModel extends AutoDisposeNotifier {
  late final ThemeRepository _themeRepository;

  @override
  build() {
    _themeRepository = ref.read(themeRepository.notifier);
  }

  Future<AppThemeType> get theme => _themeRepository.getTheme();

  void selectTheme(AppThemeType theme) {
    _themeRepository.setTheme(theme);
  }

  Future<void> signOut() async {}
}

final settingsProvider = NotifierProvider.autoDispose(
  () => SettingsViewModel(),
);
