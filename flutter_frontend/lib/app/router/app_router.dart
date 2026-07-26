import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import 'routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.home,

    routes: [
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