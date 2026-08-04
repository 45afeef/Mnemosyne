import 'package:flutter/material.dart';

import '../../domain/entities/session_feedback.dart';
import '../widgets/feedback/score_card.dart';

class LessonFeedbackPage extends StatelessWidget {
  const LessonFeedbackPage({super.key, required this.feedback});

  final SessionFeedback feedback;

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
