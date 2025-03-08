import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/providers/theme_notifier.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/route/router.dart';

class MoodTrackerApp extends ConsumerWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return theme.when(
      data: (data) {
        return MaterialApp.router(
          routerConfig: ref.watch(routerProvider),
          title: "Mood Tracker",
          theme: appThemeData(data),
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
        );
      },
      error: (error, stackTrace) {
        return CenterText(text: error.toString());
      },
      loading: () {
        return const CenterProgressIndicator();
      },
    );
  }
}
