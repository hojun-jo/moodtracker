import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/di/provider.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/route/router.dart';

class MoodTrackerApp extends ConsumerWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeRepository);

    return theme.when(
      data: (data) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: ref.watch(routerProvider),
          title: "App Title".tr(),
          theme: data.getThemeData(context.locale),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
