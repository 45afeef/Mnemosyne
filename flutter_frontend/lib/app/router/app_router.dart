import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/syllabus/presentation/pages/generating_roadmap_page.dart';
import '../../features/syllabus/presentation/pages/syllabus_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/syllabus/presentation/pages/goal_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/lesson/presentation/pages/learning_entry_page.dart';
import 'routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splash,

    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingPage(),
      ),

      GoRoute(path: Routes.home, builder: (_, __) => const HomePage()),
      GoRoute(
        path: Routes.goalSettingPage,
        builder: (_, _) => const NewGoalPage(),
      ),
      GoRoute(
        path: Routes.generatingRoadmap,
        builder: (_, _) => const GeneratingRoadmapPage(),
      ),
      GoRoute(
        path: Routes.syllabusPage,
        builder: (_, _) => const ReviewSyllabusPage(),
      ),
      GoRoute(
        path: Routes.learnEntry,
        builder: (_, _) => const LearnPathPage(),
      ),
      
    ],

    errorBuilder: (_, _) {
      return const Scaffold(body: Center(child: Text("Page not found")));
    },
  );
}
