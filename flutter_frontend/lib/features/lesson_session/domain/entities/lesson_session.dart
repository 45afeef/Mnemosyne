import 'topic.dart';

class LessonSession {
  const LessonSession({
    required this.id,
    required this.title,
    required this.topics,
  });

  final String id;

  final String title;

  final List<Topic> topics;
}
