import 'package:uuid/uuid.dart';

import '../../../../app/database_helper.dart';
import '../../domain/entities/learning_goal.dart';
import '../../domain/repositories/goal_repository.dart';

import '../models/learning_goal_model.dart';

class LearningGoalRepositoryImpl implements LearningGoalRepository {
  final DatabaseHelper databaseHelper;

  LearningGoalRepositoryImpl(this.databaseHelper);

  @override
  Future<LearningGoal> createGoal(LearningGoal goal) async {
    final db = await databaseHelper.database;

    final model = LearningGoalModel(
      id: goal.id.isEmpty ? const Uuid().v4() : goal.id,
      name: goal.name,
      description: goal.description,
      endDate: goal.endDate,
      dailyCommitment: goal.dailyCommitment,
      createdAt: goal.createdAt,
    );

    await db.insert('learning_goals', model.toMap());

    return model;
  }

  @override
  Future<List<LearningGoal>> getGoals() async {
    final db = await databaseHelper.database;
    final result = await db.query('learning_goals', orderBy: 'created_at DESC');
    return result.map((e) => LearningGoalModel.fromMap(e)).toList();
  }

  @override
  Future<LearningGoal?> getGoalById(String id) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      'learning_goals',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return LearningGoalModel.fromMap(result.first);
  }

  @override
  Future<void> updateGoal(LearningGoal goal) async {
    final db = await databaseHelper.database;

    await db.update(
      'learning_goals',
      LearningGoalModel.fromEntity(goal).toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  @override
  Future<void> deleteGoal(String id) async {
    final db = await databaseHelper.database;
    await db.delete('learning_goals', where: 'id = ?', whereArgs: [id]);
  }
}
