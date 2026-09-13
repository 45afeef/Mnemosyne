import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../../../app/data/app_api.dart';
import '../../../../app/data/database_helper.dart';
import '../../domain/entities/learning_goal.dart';
import '../../domain/entities/syllabus.dart';
import '../../domain/repositories/syllabus_repository.dart';
import '../models/learning_goal_model.dart';
import '../models/syllabus_model.dart';

class SyllabusRepositoryRemoteImpl implements SyllabusRepository {
  final AppApi remote;
  final DatabaseHelper databaseHelper;

  SyllabusRepositoryRemoteImpl(this.remote, this.databaseHelper);

  @override
  Future<Syllabus> generateFromGoal({required LearningGoal goal}) async {
    final rawResult = await remote.generateSyllabusFromGoal(
      goalPayload: LearningGoalModel.fromEntity(goal).toMap()
        ..remove('id')
        ..remove('created_at')
        ..remove('daily_commitment'),
    );

    final model = SyllabusModel.fromJson(rawResult);

    // Save the syllabus before returning back
    final db = await databaseHelper.database;
    final id = const Uuid().v4();

    // ensure the stored syllabus JSON uses the DB id so reads are consistent
    final modelToSave = SyllabusModel(
      id: id,
      title: model.title,
      description: model.description,
      subjects: model.subjects,
    );

    final data = {
      'id': id,
      'content': jsonEncode(modelToSave.toJson()),
      'goal_id': goal.id,
    };

    await db.insert('syllabuses', data);

    // mark as current syllabus and current goal
    await db.rawInsert(
      'INSERT OR REPLACE INTO app_state (key, value) VALUES (?, ?)',
      ['current_syllabus_id', id],
    );

    await db.rawInsert(
      'INSERT OR REPLACE INTO app_state (key, value) VALUES (?, ?)',
      ['current_goal_id', goal.id],
    );

    return modelToSave.toEntity();
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
  Future<Syllabus?> getLatestSyllabusForGoal(String goalId) async {
    final db = await databaseHelper.database;

    final result = await db.query(
      'syllabuses',
      columns: ['id', 'content'],
      where: 'goal_id = ?',
      whereArgs: [goalId],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (result.isEmpty) return null;

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
      'content': jsonEncode(SyllabusModel.fromEntity(syllabus).toJson()),
      'updated_at': DateTime.now().millisecondsSinceEpoch,
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
    final db = await databaseHelper.database;

    await db.delete('syllabuses', where: 'id = ?', whereArgs: [id]);

    // clear current syllabus if it was the deleted one
    final res = await db.query(
      'app_state',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['current_syllabus_id'],
      limit: 1,
    );

    if (res.isNotEmpty && res.first['value'] == id) {
      await db.delete(
        'app_state',
        where: 'key = ?',
        whereArgs: ['current_syllabus_id'],
      );
    }
  }

  @override
  Future<void> saveSyllabus(Syllabus syllabus) {
    return Future(() async {
      final db = await databaseHelper.database;

      final data = {
        'id': syllabus.id,
        'content': jsonEncode(SyllabusModel.fromEntity(syllabus).toJson()),
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      };

      // insert or replace
      await db.rawInsert(
        'INSERT OR REPLACE INTO syllabuses (id, content, updated_at) VALUES (?, ?, ?)',
        [data['id'], data['content'], data['updated_at']],
      );
    });
  }

  @override
  Future<String?> getCurrentSyllabusId() async {
    final db = await databaseHelper.database;

    final res = await db.query(
      'app_state',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['current_syllabus_id'],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return res.first['value'] as String?;
  }

  @override
  Future<Syllabus?> getCurrentSyllabus() async {
    final currentId = await getCurrentSyllabusId();
    if (currentId != null) return getSyllabusById(currentId);
    return null;
  }

  @override
  Future<void> setCurrentSyllabusId(String? id) async {
    final db = await databaseHelper.database;

    if (id == null) {
      await db.delete(
        'app_state',
        where: 'key = ?',
        whereArgs: ['current_syllabus_id'],
      );
      return;
    }

    await db.rawInsert(
      'INSERT OR REPLACE INTO app_state (key, value) VALUES (?, ?)',
      ['current_syllabus_id', id],
    );
  }

  @override
  Future<String?> getCurrentGoalId() async {
    final db = await databaseHelper.database;

    final res = await db.query(
      'app_state',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['current_goal_id'],
      limit: 1,
    );

    if (res.isEmpty) return null;

    return res.first['value'] as String?;
  }

  @override
  Future<void> setCurrentGoalId(String? id) async {
    final db = await databaseHelper.database;

    if (id == null) {
      await db.delete(
        'app_state',
        where: 'key = ?',
        whereArgs: ['current_goal_id'],
      );
      return;
    }

    await db.rawInsert(
      'INSERT OR REPLACE INTO app_state (key, value) VALUES (?, ?)',
      ['current_goal_id', id],
    );
  }
}
