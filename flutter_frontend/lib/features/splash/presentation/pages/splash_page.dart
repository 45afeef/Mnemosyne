import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/app/providers/app_providers.dart';
import 'package:mnemosyne_learn/app/router/routes.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkSavedSyllabus();
    });
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

  Future<void> _checkSavedSyllabus() async {
    final repository = ref.read(syllabusRepositoryProvider);
    final hasSavedSyllabus = await repository.hasSavedSyllabus();

    if (!mounted) return;

    context.pushReplacement(hasSavedSyllabus ? Routes.home : Routes.onboarding);
  }
}
