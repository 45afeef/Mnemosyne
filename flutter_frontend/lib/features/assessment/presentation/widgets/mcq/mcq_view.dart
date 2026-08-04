import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../lesson_session/domain/entities/session_step.dart'
    show McqStep;
import '../../../../lesson_session/presentation/providers/lesson_session_provider.dart';
import '../../providers/mcq_provider.dart';
import 'mcq_option_tile.dart';

// class McqView extends StatelessWidget {
//   const McqView({super.key, required this.step});

//   final McqStep step;

//   @override
//   Widget build(BuildContext context) {
//     final mcq = step.mcq;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(mcq.question),

//         ...mcq.options.map((option) => McqOptionTile(option: option)),
//       ],
//     );
//   }
// }

class McqView extends ConsumerWidget {
  const McqView({super.key, required this.step});

  final McqStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mcqControllerProvider(step.mcq));

    final controller = ref.read(mcqControllerProvider(step.mcq).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.mcq.question),

        ...step.mcq.options.map((option) {
          return ListTile(
            title: Text(option.text),
            selected: state.selectedOptionId == option.id,
            onTap: state.isSubmitted
                ? null
                : () => controller.selectOption(option.id),
          );
        }),

        if (state.isSubmitted)
          Column(
            children: [
              Text(state.isCorrect == true ? 'Correct' : 'Incorrect'),
              FilledButton(
                onPressed: () {
                  ref
                      .read(lessonSessionControllerProvider.notifier)
                      .completeStep(controller.result);
                },
                child: const Text('Continue'),
              ),
            ],
          )
        else
          FilledButton(
            onPressed: state.selectedOptionId == null
                ? null
                : controller.submit,
            child: const Text('Submit'),
          ),
      ],
    );
  }
}
