class McqOption {
  const McqOption({required this.id, required this.text});

  final String id;
  final String text;
}

class Mcq {
  const Mcq({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionId,
    this.explanation,
  });

  final String id;
  final String question;
  final List<McqOption> options;

  /// ID of the correct option.
  final String correctOptionId;

  /// Optional explanation shown after answering.
  final String? explanation;
}
