class FlashcardState {
  const FlashcardState({this.isFlipped = false, this.mastered = false});

  final bool isFlipped;

  final bool mastered;

  FlashcardState copyWith({bool? isFlipped, bool? mastered}) {
    return FlashcardState(
      isFlipped: isFlipped ?? this.isFlipped,
      mastered: mastered ?? this.mastered,
    );
  }
}
