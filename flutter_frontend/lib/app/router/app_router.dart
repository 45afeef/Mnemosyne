import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/features/lesson/presentation/lesson_entry.dart';
import 'package:mnemosyne_learn/features/lesson/presentation/pages/lesson_screen.dart';

import '../../features/lesson/presentation/lesson_view_model.dart';
import '../../features/lesson_session/presentation/pages/lesson_session_page.dart';
import '../../features/syllabus/presentation/pages/generating_roadmap_page.dart';
import '../../features/syllabus/presentation/pages/syllabus_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/syllabus/presentation/pages/goal_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/lesson_session/presentation/pages/session_entry_page.dart';
import '../providers/app_providers.dart'
    show lessonRepository, lessonRepositoryProvider;
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
        builder: (_, _) => const SessionEnrtyPage(),
      ),
      // GoRoute(
      //   path: '/lesson/:id',

      //   builder: (context, state) {
      //     final id = state.pathParameters['id']!;

      //     return LessonScreen(
      //       lessonId: id,
      //       viewModel: LessonViewModel(repository: lessonRepositoryProvider),
      //     );
      //   },
      // ),
      GoRoute(path: Routes.lessonSession, builder: (_,_) => LessonSessionPage()),
    ],

    errorBuilder: (_, _) {
      return const Scaffold(body: Center(child: Text("Page not found")));
    },
  );
}
