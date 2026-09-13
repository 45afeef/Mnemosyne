import 'package:flutter_riverpod/legacy.dart';

import '../../../lesson_session/domain/entities/step_result.dart';
import '../../domain/entities/mcq.dart';
import 'mcq_state.dart';

class McqController extends StateNotifier<McqState> {
  McqController({required this.mcq}) : super(const McqState());

  final Mcq mcq;

  void selectOption(String optionId) {
    if (state.isSubmitted) return;

    state = state.copyWith(selectedOptionId: optionId);
  }

  void submit() {
    if (state.selectedOptionId == null) return;

    final isCorrect = state.selectedOptionId == mcq.correctOptionId;

    state = state.copyWith(isSubmitted: true, isCorrect: isCorrect);
  }

  StepResult get result {
    return McqStepCompleted(
      stepId: mcq.id,
      selectedOptionId: state.selectedOptionId!,
      isCorrect: state.isCorrect ?? false,
    );
  }
}
