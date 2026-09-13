sealed class StepResult {
  const StepResult({required this.stepId});

  final String stepId;
}

final class LearningStepCompleted extends StepResult {
  const LearningStepCompleted({required super.stepId});
}

final class McqStepCompleted extends StepResult {
  const McqStepCompleted({
    required super.stepId,
    required this.isCorrect,
    required this.selectedOptionId,
  });

  final bool isCorrect;

  final String selectedOptionId;
}

final class FlashcardStepCompleted extends StepResult {
  const FlashcardStepCompleted({required super.stepId, required this.mastered});

  final bool mastered;
}
