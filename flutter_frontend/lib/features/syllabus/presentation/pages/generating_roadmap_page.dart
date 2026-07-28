import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../widgets/ai_loader.dart';
import '../widgets/loading_step.dart';
import '../widgets/shimmer_progress_bar.dart';

class GeneratingRoadmapPage extends StatefulWidget {
  const GeneratingRoadmapPage({super.key});

  @override
  State<GeneratingRoadmapPage> createState() => _GeneratingRoadmapPageState();
}

class _GeneratingRoadmapPageState extends State<GeneratingRoadmapPage> {
  int currentStep = -1;
  int captionIndex = 0;

  bool _minimumAnimationCompleted = false;
  bool _roadmapReady = false;
  bool _showReadyState = false;

  Timer? _stepTimer;
  Timer? _captionTimer;

  final captions = const [
    "Understanding your learning goal...",
    "Searching trusted resources...",
    "Designing your syllabus...",
    "Personalizing your roadmap...",
    "Checking prerequisite topics...",
    "Optimizing lesson order...",
    "Balancing learning difficulty...",
    "Preparing your journey...",
  ];

  @override
  void initState() {
    super.initState();

    _startMinimumExperience();

    _startCaptionLoop();

    _generateRoadmap();
  }

  /// Guarantees user sees the complete first animation
  void _startMinimumExperience() {
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      _stepTimer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (currentStep < 2) {
          setState(() {
            currentStep++;
          });
        } else {
          timer.cancel();

          Future.delayed(const Duration(milliseconds: 1200), () {
            if (!mounted) return;

            _minimumAnimationCompleted = true;

            _checkCompletion();
          });
        }
      });
    });
  }

  /// Keeps AI thinking messages alive
  void _startCaptionLoop() {
    _captionTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      setState(() {
        captionIndex = (captionIndex + 1) % captions.length;
      });
    });
  }

  /// Replace this with your real API call
  Future<void> _generateRoadmap() async {
    try {
      // TODO:
      // final roadmap =
      // await roadmapRepository.generate(...);

      // Dummy AI delay
      await Future.delayed(const Duration(seconds: 5));

      _roadmapReady = true;

      _checkCompletion();
    } catch (e) {
      // Handle failure
    }
  }

  void _checkCompletion() {
    if (!_minimumAnimationCompleted || !_roadmapReady) {
      return;
    }

    setState(() {
      _showReadyState = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      // Replace with your navigation
      //
      // context.go(
      //   Routes.roadmap,
      //   extra: roadmap,
      // );
    });
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _captionTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1.1,

            colors: [Color(0xff152742), AppColors.background],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.mobileMargin,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const AiLoader(),

                    const SizedBox(height: 42),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),

                      child: Text(
                        _showReadyState
                            ? "Journey Ready"
                            : "Crafting your path...",

                        key: ValueKey(_showReadyState),

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: _showReadyState
                              ? AppColors.success
                              : AppColors.onSurface,

                          fontWeight: FontWeight.bold,

                          fontSize: 30,
                        ),
                      ),
                    ).animate().fadeIn().slideY(begin: .15),

                    const SizedBox(height: 48),

                    LoadingStep(
                      title: "Understanding your goal",
                      visible: currentStep >= 0,
                    ),

                    LoadingStep(
                      title: "Building syllabus",
                      visible: currentStep >= 1,
                    ),

                    LoadingStep(
                      title: "Personalizing roadmap",
                      visible: currentStep >= 2,
                    ),

                    const SizedBox(height: 36),

                    const ShimmerProgressBar(),

                    const SizedBox(height: 20),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),

                      child: Text(
                        _showReadyState
                            ? "Your personalized roadmap is ready"
                            : captions[captionIndex],

                        key: ValueKey(_showReadyState ? "ready" : captionIndex),

                        style: const TextStyle(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
