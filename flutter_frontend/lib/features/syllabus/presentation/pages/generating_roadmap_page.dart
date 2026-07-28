import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/syllabus_provider.dart';
import '../state/syllabus_status.dart';

import '../../../../app/theme/app_buttons.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

import '../widgets/ai_loader.dart';
import '../widgets/loading_step.dart';
import '../widgets/shimmer_progress_bar.dart';

class GeneratingRoadmapPage extends ConsumerStatefulWidget {
  const GeneratingRoadmapPage({super.key});

  @override
  ConsumerState<GeneratingRoadmapPage> createState() =>
      _GeneratingRoadmapPageState();
}

class _GeneratingRoadmapPageState extends ConsumerState<GeneratingRoadmapPage> {
  int currentStep = -1;
  int captionIndex = 0;

  bool _minimumAnimationCompleted = false;

  Timer? _stepTimer;
  Timer? _captionTimer;

  final captions = const [
    "Understanding your learning goal...",
    "Searching trusted resources...",
    "Designing your syllabus...",
    "Personalizing your roadmap...",
    "Checking prerequisite topics...",
    "Optimizing lesson order...",
    "Preparing your journey...",
  ];

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(syllabusNotifierProvider.notifier).generateSyllabus();
    // });

    _startExperience();

    _startCaptionLoop();
  }

  void _startExperience() {
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      _stepTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
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

          Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return;

            setState(() {
              _minimumAnimationCompleted = true;
            });
          });
        }
      });
    });
  }

  void _startCaptionLoop() {
    _captionTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      setState(() {
        captionIndex = (captionIndex + 1) % captions.length;
      });
    });
  }

  bool get _canContinue {
    final state = ref.read(syllabusNotifierProvider);

    return _minimumAnimationCompleted && state.status == SyllabusStatus.ready;
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _captionTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roadmapState = ref.watch(syllabusNotifierProvider);

    final ready =
        _minimumAnimationCompleted &&
        roadmapState.status == SyllabusStatus.ready;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
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
                      ready ? "Journey Ready" : "Crafting your path...",

                      key: ValueKey(ready),

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: ready ? AppColors.success : AppColors.onSurface,

                        fontSize: 30,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

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
                      ready
                          ? "Your learning journey is ready"
                          : captions[captionIndex],

                      key: ValueKey(ready ? "ready" : captionIndex),

                      style: const TextStyle(color: AppColors.onSurfaceVariant),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    height: 60,
                    child: AnimatedOpacity(
                      opacity: ready ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: IgnorePointer(
                        ignoring: !ready,
                        child: PrimaryCTAButton(
                          text: "View My Learning Path",
                          icon: Icons.arrow_forward,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
