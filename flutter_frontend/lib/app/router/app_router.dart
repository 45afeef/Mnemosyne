import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splash,

    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: Routes.home,
        builder: (_, __) => const HomePage(),
      ),
    ],

    errorBuilder: (_, __) {
      return const Scaffold(
        body: Center(
          child: Text("Page not found"),
        ),
      );
    },
  );
}
