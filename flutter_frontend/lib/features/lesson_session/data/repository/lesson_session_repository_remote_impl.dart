import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../app/data/app_api.dart';
import '../../../../app/data/database_helper.dart';
import '../../../syllabus/data/models/syllabus_model.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/repository/lesson_session_repository.dart';
import '../models/lession_session_model.dart';
import '../models/lesson_session_storage_model.dart';

class LessonSessionRepositoryRemoteImpl implements LessonSessionRepository {
  LessonSessionRepositoryRemoteImpl(this.remoteDataSource, this.databaseHelper);
  final AppApi remoteDataSource;
  final DatabaseHelper databaseHelper;

  @override
  Future<LessonSession> generateSession({
    required List<String> learningItemIds,
  }) async {
    // First check the database cache.
    final cachedSession = await _getSessionByLearningItemIds(learningItemIds);

    if (cachedSession != null) {
      return cachedSession;
    }

    // Nothing cached, so generate a new session.

    // Before that get necessary details to create payload
    // includes goal, topic, and learning Items name, description and content
    final db = await databaseHelper.database;

    // GET GOAL
    final appRes = await db.query(
      'app_state',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['current_goal_id'],
      limit: 1,
    );

    if (appRes.isEmpty) {
      throw Exception("No selected goal found, please create or select one");
    }
    String goalId = appRes.first['value'] as String;

    final goalRes = await db.query(
      'learning_goals',
      columns: ['name', 'description'],
      where: 'id = ?',
      whereArgs: [goalId],
      limit: 1,
    );
    final goalString =
        "${goalRes.first['name']} - ${goalRes.first['description']}";

    // GET TOPIC
    // syllabusRepositoryProvider
    final appCurrentSyllabusRes = await db.query(
      'app_state',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['current_syllabus_id'],
      limit: 1,
    );

    if (appCurrentSyllabusRes.isEmpty) {
      return throw Exception("No selected syllabus found, please select one");
    }

    String syllabusId = appCurrentSyllabusRes.first['value'] as String;
    final syllabusRes = await db.query(
      'syllabuses',
      columns: ['content'],
      where: 'id = ?',
      whereArgs: [syllabusId],
      limit: 1,
    );

    if (syllabusRes.isEmpty) {
      return throw Exception("No syllabus found, please create or select one");
    }

    final json =
        jsonDecode(syllabusRes.first['content'] as String)
            as Map<String, dynamic>;

    final syllabusModel = SyllabusModel.fromJson(json);

    // Find the learning Items details
    String topic = "";
    List<Map<String, String>> itemsData = [];
    for (final subject in syllabusModel.subjects) {
      for (final module in subject.modules) {
        for (final item in module.learningItems) {
          if (learningItemIds.contains(item.id)) {
            topic = "$topic ${subject.name}->${module.name}";
            itemsData.add({
              'name': item.title,
              'description': item.description,
              'content': item.content,
            });
          }
        }
      }
    }

    final model = await remoteDataSource.generateLessonSession(
      payload: {
        'goal': goalString,
        'topic': topic,
        'learning_items': itemsData,
      },
    );

    await _saveSession(
      model,
      isCompleted: false,
      learningItemIds: learningItemIds,
    );

    return model.toEntity();
  }

  @override
  Future<void> completeSession(String id) async {
    final db = await databaseHelper.database;

    final result = await db.update(
      'lesson_sessions',
      {'is_completed': 1, 'updated_at': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );

    debugPrint('Here is the result $result');
  }

  @override
  Future<void> deleteSession(String id) async {
    final db = await databaseHelper.database;
    await db.delete('lesson_sessions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<LessonSession>> getSessions() async {
    final db = await databaseHelper.database;
    final rows = await db.query('lesson_sessions', orderBy: 'created_at DESC');

    return rows
        .map(
          (row) => LessonSessionModel.fromJson(
            jsonDecode(row['content'] as String) as Map<String, dynamic>,
          ).toEntity(),
        )
        .toList();
  }

  @override
  Future<LessonSession?> getSessionById(String id) async {
    final db = await databaseHelper.database;
    final rows = await db.query(
      'lesson_sessions',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return LessonSessionModel.fromJson(
      jsonDecode(rows.first['content'] as String) as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<LessonSession?> getUncompletedSession() async {
    final db = await databaseHelper.database;
    final rows = await db.query(
      'lesson_sessions',
      where: 'is_completed = ?',
      whereArgs: [0],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return LessonSessionModel.fromJson(
      jsonDecode(rows.first['content'] as String) as Map<String, dynamic>,
    ).toEntity();
  }

  Future<void> _saveSession(
    LessonSessionModel model, {
    required bool isCompleted,
    required List<String> learningItemIds,
  }) async {
    final db = await databaseHelper.database;
    final stored = LessonSessionStorageModel.fromSessionModel(model).copyWith(
      isCompleted: isCompleted,
      learingItemIDs: jsonEncode(learningItemIds),
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await db.insert(
      'lesson_sessions',
      stored.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<LessonSession?> _getSessionByLearningItemIds(
    List<String> learningItemIds,
  ) async {
    if (learningItemIds.isEmpty) {
      return null;
    }

    final db = await databaseHelper.database;

    final rows = await db.query('lesson_sessions', orderBy: 'updated_at DESC');

    final requestedIds = learningItemIds.toSet();

    for (final row in rows) {
      final storedIds = (jsonDecode(row['learning_item_ids'] as String) as List)
          .cast<String>()
          .toSet();

      if (storedIds.length == requestedIds.length &&
          storedIds.containsAll(requestedIds)) {
        return LessonSessionModel.fromJson(
          jsonDecode(row['content'] as String) as Map<String, dynamic>,
        ).toEntity();
      }
    }

    return null;
  }
}
