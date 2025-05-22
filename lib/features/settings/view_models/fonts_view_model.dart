import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';

class FontsViewModel extends Notifier<AsyncValue<AppFontsType>> {
  @override
  AsyncValue<AppFontsType> build() {
    return ref.watch(themeRepository).when(
          data: (data) {
            return AsyncValue.data(data.fonts);
          },
          error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
          loading: () => const AsyncValue.loading(),
        );
  }

  void selectFonts(AppFontsType fonts) {
    ref.read(themeRepository.notifier).setFonts(fonts);
  }
}

final fontsProvider =
    NotifierProvider<FontsViewModel, AsyncValue<AppFontsType>>(
  () => FontsViewModel(),
);
