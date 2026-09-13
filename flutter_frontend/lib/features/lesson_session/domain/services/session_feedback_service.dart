import '../entities/session_feedback.dart';
import '../entities/session_result.dart';
import '../entities/step_result.dart';

class SessionFeedbackService {
  const SessionFeedbackService();

  SessionFeedback generate(SessionResult result) {
    final total = result.stepResults.length;

    if (total == 0) {
      return const SessionFeedback(
        title: 'Session completed',
        message: 'No activities were completed.',
        score: 0,
        tips: [],
      );
    }

    final correctAnswers = result.stepResults
        .whereType<McqStepCompleted>()
        .where((result) => result.isCorrect)
        .length;

    final mcqCount = result.stepResults.whereType<McqStepCompleted>().length;

    final score = mcqCount == 0 ? 1.0 : correctAnswers / mcqCount;

    return SessionFeedback(
      title: score >= 0.8 ? 'Great work!' : 'Keep practicing!',
      message: score >= 0.8
          ? 'You have a strong understanding of this topic.'
          : 'Review the concepts and try again.',
      score: score,
      tips: score >= 0.8
          ? const [
              FeedbackTip(
                title: 'Continue learning',
                description: 'Move on to the next topic.',
              ),
            ]
          : const [
              FeedbackTip(
                title: 'Review mistakes',
                description: 'Focus on the questions you missed.',
              ),
            ],
    );
  }
}
