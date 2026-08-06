import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnemosyne_learn/features/lesson_session/domain/entities/session_step.dart';
import 'package:mnemosyne_learn/features/lesson_session/presentation/controllers/lesson_session_state.dart';

import '../../../assessment/presentation/pages/assessment_page.dart';
import '../../../learning/presentation/pages/learning_page.dart';
import '../providers/lesson_session_provider.dart';

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
      LearningStep() => LearningPage(key: ValueKey(step.id), step: step),

      McqStep() => AssessmentPage(key: ValueKey(step.id), step: step),

      FlashcardStep() => AssessmentPage(key: ValueKey(step.id), step: step),
    };
  }
}
