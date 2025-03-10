import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';
import 'package:moodtracker/features/authentication/views/sign_in_screen.dart';
import 'package:moodtracker/features/authentication/views/sign_up_screen.dart';
import 'package:moodtracker/route/route_path.dart';
import 'package:moodtracker/core/widgets/main_navigation/main_navigation_bar.dart';
import 'package:moodtracker/features/home/views/home_screen.dart';
import 'package:moodtracker/features/settings/views/settings_screen.dart';
import 'package:moodtracker/features/write/views/write_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: RoutePath.home,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != RoutePath.signIn &&
            state.matchedLocation != RoutePath.signUp) {
          return RoutePath.signIn;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePath.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePath.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainNavigationBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.write,
                builder: (context, state) => const WriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
