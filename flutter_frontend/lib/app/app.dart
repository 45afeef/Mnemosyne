import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: "Flutter Boilerplate",

      theme: AppTheme.light,

      darkTheme: AppTheme.dark,

      themeMode: ThemeMode.system,

      routerConfig: AppRouter.router,
    );
  }
}
