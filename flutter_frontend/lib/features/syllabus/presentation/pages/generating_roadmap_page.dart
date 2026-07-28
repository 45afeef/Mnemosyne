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
  State<GeneratingRoadmapPage> createState() =>
      _GeneratingRoadmapPageState();
}

class _GeneratingRoadmapPageState extends State<GeneratingRoadmapPage> {
  int currentStep = -1;
  int captionIndex = 0;

  Timer? _stepTimer;
  Timer? _captionTimer;

  final captions = const [
    "Understanding your learning goal...",
    "Searching trusted resources...",
    "Designing your syllabus...",
    "Personalizing your roadmap...",
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      _stepTimer = Timer.periodic(
        const Duration(milliseconds: 1500),
        (timer) {
          if (currentStep >= 2) {
            timer.cancel();
            return;
          }

          setState(() => currentStep++);
        },
      );
    });

    _captionTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (!mounted) return;

        setState(() {
          captionIndex = (captionIndex + 1) % captions.length;
        });
      },
    );
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
            colors: [
              Color(0xff152742),
              AppColors.background,
            ],
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

                    Text(
                      "Crafting your path...",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                        .animate()
                        .fadeIn()
                        .slideY(begin: .15),

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
                        captions[captionIndex],
                        key: ValueKey(captionIndex),
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