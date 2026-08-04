import '../entities/lesson.dart';

abstract interface class LessonRepository {
  Future<Lesson> getLesson(String lessonId);
}
