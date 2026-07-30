import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../app/router/routes.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    final repository = ref.read(syllabusRepositoryProvider);

    final results = await Future.wait([
      Future<void>.delayed(const Duration(seconds: 2)),
      repository.hasSavedSyllabus(),
    ]);

    if (!mounted) return;

    final hasSavedSyllabus = results[1] as bool;
    context.go(hasSavedSyllabus ? Routes.home : Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SplashBackground(),
          SafeArea(child: Center(child: SplashContent())),
        ],
      ),
    );
  }
}
