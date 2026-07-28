import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/syllabus_repository.dart';

import '../data_source/syllabus_remote_datasource.dart';
import '../models/syllabus_model.dart';

class SyllabusRepositoryRemoteImpl implements SyllabusRepository {
  final SyllabusRemoteDataSource remote;

  SyllabusRepositoryRemoteImpl(this.remote);

  @override
  Future<Syllabus> generateFromGoal({required String learningGoalId}) async {
    return await remote.generateFromGoal(goalId: learningGoalId);
  }

  @override
  Future<Syllabus?> getSyllabusById(String id) async {
    return await remote.getSyllabusById(id);
  }

  @override
  Future<void> updateSyllabus(Syllabus syllabus) async {
    final model = SyllabusModel(
      id: syllabus.id,

      title: syllabus.title,

      description: syllabus.description,

      subjects: syllabus.subjects,
    );

    await remote.updateSyllabus(model);
  }

  @override
  Future<void> deleteSyllabus(String id) async {
    await remote.deleteSyllabus(id);
  }

  @override
  Future<void> saveSyllabus(Syllabus syllabus) {
    // TODO: implement saveSyllabus
    throw UnimplementedError();
  }
}
