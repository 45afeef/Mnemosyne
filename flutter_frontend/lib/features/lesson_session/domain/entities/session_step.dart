import '../../../assessment/domain/entities/flashcard.dart';
import '../../../assessment/domain/entities/mcq.dart';
import 'learning_content.dart';

/// Base class for every interactive unit inside a lesson session.
///
/// A [SessionStep] represents a single step in the learning flow.
/// Examples include:
/// - Reading markdown content
/// - Answering an MCQ
/// - Reviewing a flashcard
///
/// The session engine is responsible for sequencing these steps,
/// while each concrete step defines its own content and behaviour.
sealed class SessionStep {
  const SessionStep({required this.id, required this.title});

  /// Unique identifier for this step.
  ///
  /// Used for analytics, persistence, progress tracking, etc.
  final String id;

  /// Human-readable title.
  ///
  /// Example:
  /// "Introduction"
  /// "Question 1"
  /// "Key Concepts"
  final String title;
}

final class McqStep extends SessionStep {
  const McqStep({required super.id, required super.title, required this.mcq});

  final Mcq mcq;
}

final class LearningStep extends SessionStep {
  const LearningStep({
    required super.id,
    required super.title,
    required this.content,
  });

  final LearningContent content;
}

class FlashcardStep extends SessionStep {
  const FlashcardStep({
    required super.id,
    required super.title,
    required this.flashcard,
  });

  final Flashcard flashcard;
}
