import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../lesson_session/domain/entities/session_step.dart';
import '../../../../lesson_session/presentation/providers/lesson_session_provider.dart';
import '../../providers/flashcard_provider.dart';
import 'flashcard_back.dart';
import 'flashcard_flip.dart';
import 'flashcard_front.dart';

// class FlashcardView extends StatelessWidget {
//   const FlashcardView({super.key, required this.step});

//   final FlashcardStep step;

//   @override
//   Widget build(BuildContext context) {
//     return FlashcardFlip(
//       front: step.flashcard.front,
//       back: step.flashcard.back,
//     );
//   }
// }

class FlashcardView extends ConsumerWidget {
  const FlashcardView({super.key, required this.step});

  final FlashcardStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flashcardControllerProvider);

    final controller = ref.read(flashcardControllerProvider.notifier);

    return Column(
      children: [
        GestureDetector(
          onTap: controller.flip,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: state.isFlipped
                ? FlashcardBack(
                    key: const ValueKey('back'),
                    text: step.flashcard.back,
                  )
                : FlashcardFront(
                    key: const ValueKey('front'),
                    text: step.flashcard.front,
                  ),
          ),
        ),

        const SizedBox(height: 24),

        if (state.isFlipped)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  controller.markMastered();

                  ref
                      .read(lessonSessionControllerProvider.notifier)
                      .completeStep(controller.result(step.id));
                },
                child: const Text('I know this'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  controller.markNeedsReview();

                  ref
                      .read(lessonSessionControllerProvider.notifier)
                      .completeStep(controller.result(step.id));
                },
                child: const Text('Review again'),
              ),
            ],
          ),
      ],
    );
  }
}
