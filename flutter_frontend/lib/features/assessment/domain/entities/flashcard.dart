class Flashcard {
  const Flashcard({
    required this.id,
    required this.front,
    required this.back,
    this.hint,
  });

  final String id;

  final String front;

  final String back;

  final String? hint;
}
