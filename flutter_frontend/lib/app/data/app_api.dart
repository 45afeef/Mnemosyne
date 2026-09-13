import '../../features/lesson_session/data/models/lession_session_model.dart';

abstract class AppApi {
  Future<LessonSessionModel> generateLessonSession({
    required Map<String, dynamic> payload,
  });

  Future<TechniqueContentModel> generateTechniqueItem({required String prompt});

  Future<AssessmentContentModel> generateAssessmentItem({
    required String prompt,
  });

  Future<Map<String, dynamic>> generateSyllabusFromGoal({
    required Map<String, dynamic> goalPayload,
  });
}
