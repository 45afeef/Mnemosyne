import '../entities/learning_goal.dart';

abstract class LearningGoalRepository {
  Future<LearningGoal> createGoal(LearningGoal goal);

  Future<LearningGoal?> getGoalById(String id);

  Future<List<LearningGoal>> getGoals();

  Future<void> updateGoal(LearningGoal goal);

  Future<void> deleteGoal(String id);
}
