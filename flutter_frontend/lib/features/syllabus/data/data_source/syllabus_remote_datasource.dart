import '../models/syllabus_model.dart';

abstract class SyllabusRemoteDataSource {
  Future<SyllabusModel> generateFromGoal({required String goalId});

  Future<SyllabusModel?> getSyllabusById(String id);

  Future<void> updateSyllabus(SyllabusModel syllabus);

  Future<void> deleteSyllabus(String id);
}

class SyllabusRemoteDataSourceImpl implements SyllabusRemoteDataSource {
  @override
  Future<SyllabusModel> generateFromGoal({required String goalId}) async {
    // simulate AI generation delay

    await Future.delayed(const Duration(seconds: 5));

    return SyllabusModel.dummy(goalId);
  }

  @override
  Future<SyllabusModel?> getSyllabusById(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    return SyllabusModel.dummy(id);
  }

  @override
  Future<void> updateSyllabus(SyllabusModel syllabus) async {
    await Future.delayed(const Duration(seconds: 1));

    // pretend API saved
  }

  @override
  Future<void> deleteSyllabus(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
