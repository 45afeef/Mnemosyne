import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/session_result.dart';
import '../../domain/entities/step_result.dart';
import '../../domain/services/session_engine.dart';
import '../../domain/services/session_feedback_service.dart';
import 'lesson_session_state.dart';

class LessonSessionController extends StateNotifier<LessonSessionState> {
  LessonSessionController({required this.engine, required this.feedbackService})
    : super(const LessonSessionLoading());

  final SessionEngine engine;

  final SessionFeedbackService feedbackService;

  void start() {
    state = LessonSessionRunning(
      currentStep: engine.currentStep,
      progress: engine.progress,
    );
  }

  void completeStep(StepResult result) {
    engine.completeStep(result);

    if (engine.isFinished) {
      completeSession();
      return;
    }

    state = LessonSessionRunning(
      currentStep: engine.currentStep,
      progress: engine.progress,
    );
  }

  void completeSession() {
    state = const LessonSessionGeneratingFeedback();

    final result = engine.buildResult();

    final feedback = feedbackService.generate(result);

    state = LessonSessionCompleted(feedback: feedback);
  }
}
