import '../entities/lesson_session_old.dart';

abstract class LessonSessionRepository {
  /// Generate lesson from selected learning items
  Future<LessonSessionOld> generateSession({
    required List<String> learningItemIds,
  });

  /// Get previous generated lessons
  Future<List<LessonSessionOld>> getSessions();

  /// Get one lesson
  Future<LessonSessionOld?> getSessionById(String id);

  /// Mark lesson completed
  Future<void> completeSession(String id);

  /// Delete session
  Future<void> deleteSession(String id);
}
