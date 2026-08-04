class SessionFeedback {
  const SessionFeedback({
    required this.title,
    required this.message,
    required this.score,
    required this.tips,
  });

  final String title;

  final String message;

  final double score;

  final List<FeedbackTip> tips;
}

class FeedbackTip {
  const FeedbackTip({
    required this.title,
    required this.description,
  });

  final String title;

  final String description;
}