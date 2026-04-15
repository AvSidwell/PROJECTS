import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/skills/skills_library_screen.dart';
import '../../presentation/screens/skill_detail/skill_detail_screen.dart';
import '../../presentation/screens/progression/progression_screen.dart';
import '../../presentation/screens/hurdles/hurdles_screen.dart';
import '../../presentation/screens/daily_practice/daily_practice_screen.dart';
import '../../presentation/screens/progress_tracking/progress_tracking_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter createRouter(SharedPreferences prefs) {
  final onboardingDone = prefs.getBool('onboarding_complete') ?? false;

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: onboardingDone ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => _MainShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/skills',
              builder: (_, __) => const SkillsLibraryScreen(),
              routes: [
                GoRoute(
                  path: ':skillId',
                  builder: (_, state) =>
                      SkillDetailScreen(skillId: state.pathParameters['skillId']!),
                  routes: [
                    GoRoute(
                      path: 'progression',
                      builder: (_, state) =>
                          ProgressionScreen(skillId: state.pathParameters['skillId']!),
                    ),
                    GoRoute(
                      path: 'hurdles',
                      builder: (_, state) =>
                          HurdlesScreen(skillId: state.pathParameters['skillId']!),
                    ),
                    GoRoute(
                      path: 'practice',
                      builder: (_, state) =>
                          DailyPracticeScreen(skillId: state.pathParameters['skillId']!),
                    ),
                  ],
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/progress', builder: (_, __) => const ProgressTrackingScreen()),
          ]),
        ],
      ),
    ],
  );
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view_rounded),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart_rounded),
          label: 'Progress',
        ),
      ],
    );
  }
}
