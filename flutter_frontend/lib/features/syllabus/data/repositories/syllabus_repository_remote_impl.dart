import 'dart:convert';

import 'package:mnemosyne_learn/features/syllabus/domain/entities/learning_goal.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/syllabus_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/database_helper.dart';
import '../data_source/syllabus_remote_datasource.dart';
import '../models/syllabus_model.dart';

class SyllabusRepositoryRemoteImpl implements SyllabusRepository {
  final SyllabusRemoteDataSource remote;
  final DatabaseHelper databaseHelper;

  SyllabusRepositoryRemoteImpl(this.remote, this.databaseHelper);

  @override
  Future<Syllabus> generateFromGoal({
    required LearningGoal learningGoal,
  }) async {
    final model = await remote.generateFromGoal(learningGoal: learningGoal);

    // Save the syllabus before returning back
    final db = await databaseHelper.database;
    final data = {'id': Uuid().v4(), 'content': jsonEncode(model.toJson())};

    await db.insert('syllabuses', data);

    return model.toEntity();
  }

  @override
  Future<Syllabus?> getSyllabusById(String id) async {
    final db = await databaseHelper.database;

    final result = await db.query(
      'syllabuses',
      columns: ['content'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    final json =
        jsonDecode(result.first['content'] as String) as Map<String, dynamic>;

    final model = SyllabusModel.fromJson(json);
    return model.toEntity();
  }

  @override
  Future<bool> hasSavedSyllabus() async {
    final db = await databaseHelper.database;

    final result = await db.query('syllabuses', columns: ['id'], limit: 1);

    return result.isNotEmpty;
  }

  @override
  Future<void> updateSyllabus(Syllabus syllabus) async {
    final db = await databaseHelper.database;

    final data = {
      'id': Uuid().v4(),
      'content': jsonEncode(SyllabusModel.fromEntity(syllabus).toJson()),
    };

    await db.update(
      'syllabuses',
      data,
      where: 'id = ?',
      whereArgs: [syllabus.id],
    );
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
