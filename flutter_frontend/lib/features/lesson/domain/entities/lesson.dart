import '../../presentation/models/lesson_block.dart';

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.progress,
    required this.blocks,
    this.assistantActions = const [],
  });

  final String id;

  final String title;

  /// Overall course progress (0.0 - 1.0)
  final double progress;

  final List<LessonBlock> blocks;

  final List<LessonAssistantAction> assistantActions;
}

class LessonAssistantAction {
  const LessonAssistantAction({required this.label, this.actionType});

  final String label;

  /// Can be used later for server-driven actions.
  ///
  /// Example:
  /// "explain"
  /// "example"
  /// "quiz"
  /// "simplify"
  final String? actionType;
}
