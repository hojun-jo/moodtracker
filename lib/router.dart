import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/constants/app_route.dart';
import 'package:moodtracker/core/widgets/main_navigation/main_navigation_bar.dart';
import 'package:moodtracker/features/home/views/home_screen.dart';
import 'package:moodtracker/features/settings/views/settings_screen.dart';
import 'package:moodtracker/features/write/views/write_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainNavigationBar(child: child),
      routes: [
        GoRoute(
          path: AppRoute.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoute.write,
          builder: (context, state) => const WriteScreen(),
        ),
        GoRoute(
          path: AppRoute.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
