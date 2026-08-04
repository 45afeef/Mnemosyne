import 'package:flutter_riverpod/legacy.dart';

import '../../../lesson_session/domain/entities/step_result.dart';
import 'flashcard_state.dart';

class FlashcardController extends StateNotifier<FlashcardState> {
  FlashcardController() : super(const FlashcardState());

  void flip() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void markMastered() {
    state = state.copyWith(mastered: true);
  }

  void markNeedsReview() {
    state = state.copyWith(mastered: false);
  }

  StepResult result(String stepId) {
    return FlashcardStepCompleted(stepId: stepId, mastered: state.mastered);
  }
}
