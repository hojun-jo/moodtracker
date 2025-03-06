import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/theme/app_theme_data.dart';
import 'package:moodtracker/core/theme/app_theme_type.dart';
import 'package:moodtracker/route/router.dart';

class MoodTrackerApp extends ConsumerWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: "Mood Tracker",
      theme: appThemeData(AppThemeType.white),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
