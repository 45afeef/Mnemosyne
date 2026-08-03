import 'package:mnemosyne_learn/features/lesson_session/domain/entities/learning_session_item.dart';

class LessonSession {
  final String id;
  final String topicName;
  final List<LessonItem> learningItems;

  const LessonSession({
    required this.id,
    required this.topicName,
    required this.learningItems,
  });
}
