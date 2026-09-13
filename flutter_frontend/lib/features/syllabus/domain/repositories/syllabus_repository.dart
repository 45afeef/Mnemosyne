import '../entities/learning_goal.dart';
import '../entities/syllabus.dart';

abstract class SyllabusRepository {
  /// Generate initial syllabus from learning goal
  Future<Syllabus> generateFromGoal({required LearningGoal goal});

  /// Load existing syllabus
  Future<Syllabus?> getSyllabusById(String id);

  /// Check whether any syllabus exists in the local database
  Future<bool> hasSavedSyllabus();

  /// Save user modifications
  Future<void> updateSyllabus(Syllabus syllabus);

  /// Replace a subject/module/item tree
  Future<void> saveSyllabus(Syllabus syllabus);

  /// Get the id of the currently active syllabus (if any)
  Future<String?> getCurrentSyllabusId();

  /// Get the currently active syllabus (if any)
  Future<Syllabus?> getCurrentSyllabus();

  /// Set the id of the currently active syllabus (or null to clear)
  Future<void> setCurrentSyllabusId(String? id);

  /// Get the id of the currently selected learning goal
  Future<String?> getCurrentGoalId();

  /// Set the id of the currently selected learning goal
  Future<void> setCurrentGoalId(String? id);

  /// Get the most recently created syllabus for a given goal, if any
  Future<Syllabus?> getLatestSyllabusForGoal(String goalId);

  /// Delete syllabus
  Future<void> deleteSyllabus(String id);
}
