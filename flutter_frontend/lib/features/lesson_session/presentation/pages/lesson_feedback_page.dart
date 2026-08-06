import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/app/theme/app_buttons.dart';
import 'package:mnemosyne_learn/features/lesson_session/presentation/providers/lesson_session_provider.dart';

import '../../domain/entities/session_feedback.dart';
import '../widgets/feedback/score_card.dart';

class LessonFeedbackPage extends ConsumerWidget {
  const LessonFeedbackPage({super.key, required this.feedback});

  final SessionFeedback feedback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(feedback.title),

            const SizedBox(height: 12),

            Text(feedback.message),

            const SizedBox(height: 24),

            ScoreCard(score: feedback.score),

            const SizedBox(height: 24),

            ...feedback.tips.map(
              (tip) => ListTile(
                title: Text(tip.title),
                subtitle: Text(tip.description),
              ),
            ),

            PrimaryCTAButton(
              text: "Close",
              onPressed: () {
                ref.read(lessonSessionControllerProvider.notifier).reset();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
