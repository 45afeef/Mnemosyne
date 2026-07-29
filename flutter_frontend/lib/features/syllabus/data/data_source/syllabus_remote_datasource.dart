import '../../domain/entities/learning_goal.dart';
import '../models/syllabus_model.dart';

abstract class SyllabusRemoteDataSource {
  Future<SyllabusModel> generateFromGoal({required LearningGoal learningGoal});

  Future<SyllabusModel?> getSyllabusById(String id);

  Future<void> updateSyllabus(SyllabusModel syllabus);

  Future<void> deleteSyllabus(String id);
}

class SyllabusRemoteDataSourceImpl implements SyllabusRemoteDataSource {
  @override
  Future<SyllabusModel> generateFromGoal({
    required LearningGoal learningGoal,
  }) async {
    // simulate AI generation delay
    await Future.delayed(const Duration(seconds: 5));

    return SyllabusModel.dummy("dummy_id");
  }

  @override
  Future<SyllabusModel?> getSyllabusById(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    return SyllabusModel.dummy(id);
  }

  @override
  Future<void> updateSyllabus(SyllabusModel syllabus) async {
    throw UnimplementedError("The Syllabus Deletion is not yet implemented");
  }

  @override
  Future<void> deleteSyllabus(String id) async {
    throw UnimplementedError("The Syllabus Deletion is not yet implemented");
  }
}
