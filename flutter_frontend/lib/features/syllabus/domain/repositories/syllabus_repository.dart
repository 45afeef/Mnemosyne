import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';

abstract class SyllabusRepository {
  /// Generate initial syllabus from learning goal
  Future<Syllabus> generateFromGoal({required String learningGoalId});

  /// Load existing syllabus
  Future<Syllabus?> getSyllabusById(String id);

  /// Save user modifications
  Future<void> updateSyllabus(Syllabus syllabus);

  /// Replace a subject/module/item tree
  Future<void> saveSyllabus(Syllabus syllabus);

  /// Delete syllabus
  Future<void> deleteSyllabus(String id);
}
