import '../../domain/entities/session_feedback.dart';
import '../../domain/entities/session_step.dart';

sealed class LessonSessionState {
  const LessonSessionState();
}

final class LessonSessionLoading extends LessonSessionState {
  const LessonSessionLoading();
}

final class LessonSessionRunning extends LessonSessionState {
  const LessonSessionRunning({
    required this.currentStep,
    required this.progress,
  });

  final SessionStep currentStep;

  final double progress;
}

final class LessonSessionGeneratingFeedback extends LessonSessionState {
  const LessonSessionGeneratingFeedback();
}

final class LessonSessionCompleted extends LessonSessionState {
  const LessonSessionCompleted({required this.feedback});

  final SessionFeedback feedback;
}

final class LessonSessionFailed extends LessonSessionState {
  const LessonSessionFailed({required this.error});
  final String error;
}
