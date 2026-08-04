import 'package:flutter/material.dart';

import '../../../lesson_session/domain/entities/session_step.dart';
import 'flashcard/flashcard_view.dart';
import 'mcq/mcq_view.dart';

class AssessmentHost extends StatelessWidget {
  const AssessmentHost({super.key, required this.step});

  final SessionStep step;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      McqStep() => McqView(step: step as McqStep),

      FlashcardStep() => FlashcardView(step: step as FlashcardStep),

      _ => const SizedBox.shrink(),
    };
  }
}
