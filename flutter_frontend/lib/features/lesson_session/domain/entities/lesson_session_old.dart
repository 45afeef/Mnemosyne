import 'package:mnemosyne_learn/features/lesson_session/domain/entities/learning_session_item.dart';

class LessonSessionOld {
  final String id;
  final String topicName;
  final List<LessonItem> learningItems;

  const LessonSessionOld({
    required this.id,
    required this.topicName,
    required this.learningItems,
  });
}
