import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/session_step.dart';
import '../../domain/entities/step_result.dart';
import '../controllers/lesson_session_state.dart';
import '../providers/lesson_session_provider.dart';

class SessionBottomBar extends ConsumerWidget {
  const SessionBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonSessionControllerProvider);

    if (state is! LessonSessionRunning) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton(
          onPressed: () {
            final step = state.currentStep;

            if (step is LearningStep) {
              ref
                  .read(lessonSessionControllerProvider.notifier)
                  .completeStep(LearningStepCompleted(stepId: step.id));
            }
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
