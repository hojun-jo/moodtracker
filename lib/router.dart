import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/constants/app_route.dart';
import 'package:moodtracker/features/home/views/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.home,
  routes: [
    GoRoute(
      path: AppRoute.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
