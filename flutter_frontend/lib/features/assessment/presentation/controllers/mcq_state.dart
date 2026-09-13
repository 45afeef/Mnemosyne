class McqState {
  const McqState({
    this.selectedOptionId,
    this.isSubmitted = false,
    this.isCorrect,
  });

  final String? selectedOptionId;

  final bool isSubmitted;

  final bool? isCorrect;

  McqState copyWith({
    String? selectedOptionId,
    bool? isSubmitted,
    bool? isCorrect,
  }) {
    return McqState(
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
