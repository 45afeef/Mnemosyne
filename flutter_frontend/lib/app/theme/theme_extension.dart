import 'package:flutter/material.dart';

@immutable
class LearningColors extends ThemeExtension<LearningColors> {
  final Color activeRecall;
  final Color spacedRepetition;
  final Color interleavedPractice;

  const LearningColors({
    required this.activeRecall,
    required this.spacedRepetition,
    required this.interleavedPractice,
  });

  @override
  LearningColors copyWith({
    Color? activeRecall,
    Color? spacedRepetition,
    Color? interleavedPractice,
  }) {
    return LearningColors(
      activeRecall: activeRecall ?? this.activeRecall,
      spacedRepetition:
          spacedRepetition ?? this.spacedRepetition,
      interleavedPractice:
          interleavedPractice ?? this.interleavedPractice,
    );
  }

  @override
  LearningColors lerp(
    covariant LearningColors? other,
    double t,
  ) {
    if (other == null) return this;

    return LearningColors(
      activeRecall:
          Color.lerp(activeRecall, other.activeRecall, t)!,
      spacedRepetition:
          Color.lerp(spacedRepetition, other.spacedRepetition, t)!,
      interleavedPractice:
          Color.lerp(interleavedPractice, other.interleavedPractice, t)!,
    );
  }
}