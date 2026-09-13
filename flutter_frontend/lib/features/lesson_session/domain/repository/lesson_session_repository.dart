import '../entities/lesson_session.dart';

abstract class LessonSessionRepository {
  /// Generate lesson from selected learning items
  Future<LessonSession> generateSession({
    required List<String> learningItemIds,
  });

  /// Get previous generated lessons
  Future<List<LessonSession>> getSessions();

  /// Get one lesson
  Future<LessonSession?> getSessionById(String id);

  /// Get an uncompleted session if one exists
  Future<LessonSession?> getUncompletedSession();

  /// Mark lesson completed
  Future<void> completeSession(String id);

  /// Delete session
  Future<void> deleteSession(String id);
}
