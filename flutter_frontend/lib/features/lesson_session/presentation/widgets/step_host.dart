import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assessment/presentation/pages/assessment_page.dart';
import '../../../lesson/presentation/pages/lesson_screen.dart';
import '../../domain/entities/session_step.dart';
import '../providers/lesson_session_provider.dart';
import '../states/lesson_session_state.dart';

class StepHost extends ConsumerWidget {
  const StepHost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonSessionControllerProvider);

    if (state is! LessonSessionRunning) {
      return const SizedBox.shrink();
    }

    final step = state.currentStep;

    return switch (step) {
      LearningStep() => LessonScreen(key: ValueKey(step.id), step: step),

      McqStep() => AssessmentPage(key: ValueKey(step.id), step: step),

      FlashcardStep() => AssessmentPage(key: ValueKey(step.id), step: step),
    };
  }
}
