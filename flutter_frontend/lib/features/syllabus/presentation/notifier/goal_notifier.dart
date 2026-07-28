import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/learning_goal.dart';

import '../../domain/repositories/goal_repository.dart';
import '../state/goal_state.dart';

import '../state/goal_status.dart';

class GoalNotifier extends StateNotifier<GoalState> {
  final LearningGoalRepository repository;

  GoalNotifier(this.repository) : super(const GoalState());

  // Start creating a new goal
  void startCreatingGoal() {
    state = state.copyWith(
      draftGoal: LearningGoal(id: '', name: '', createdAt: DateTime.now()),
      status: GoalStatus.initial,
    );
  }

  // Update draft name
  void updateName(String name) {
    final goal = state.draftGoal;

    if (goal == null) return;

    state = state.copyWith(draftGoal: goal.copyWith(name: name));
  }

  void updateDescription(String? description) {
    final goal = state.draftGoal;

    if (goal == null) return;

    state = state.copyWith(draftGoal: goal.copyWith(description: description));
  }

  void updateEndDate(DateTime? date) {
    final goal = state.draftGoal;

    if (goal == null) return;

    state = state.copyWith(draftGoal: goal.copyWith(endDate: date));
  }

  void updateDailyCommitment(Duration? duration) {
    final goal = state.draftGoal;

    if (goal == null) return;

    state = state.copyWith(draftGoal: goal.copyWith(dailyCommitment: duration));
  }

  bool validateDraft() {
    final goal = state.draftGoal;

    if (goal == null) {
      return false;
    }

    if (goal.name.trim().isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> saveGoal() async {
    if (!validateDraft()) {
      state = state.copyWith(
        status: GoalStatus.failure,
        errorMessage: "Goal name is required",
      );

      return;
    }

    state = state.copyWith(status: GoalStatus.loading);

    try {
      final savedGoal = await repository.createGoal(state.draftGoal!);

      state = state.copyWith(
        goals: [...state.goals, savedGoal],
        selectedGoal: savedGoal,
        draftGoal: null,
        status: GoalStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: GoalStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  void cancelCreatingGoal() {
    state = state.copyWith(draftGoal: null, status: GoalStatus.initial);
  }

  Future<void> loadGoals() async {
    state = state.copyWith(status: GoalStatus.loading);

    try {
      final goals = await repository.getGoals();

      state = state.copyWith(goals: goals, status: GoalStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: GoalStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  void selectGoal(LearningGoal goal) {
    state = state.copyWith(selectedGoal: goal);
  }

  Future<void> createGoal(LearningGoal goal) async {
    state = state.copyWith(status: GoalStatus.loading);

    try {
      final createdGoal = await repository.createGoal(goal);

      state = state.copyWith(
        goals: [...state.goals, createdGoal],
        selectedGoal: createdGoal,
        status: GoalStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: GoalStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchGoalById(String id) async {
    state = state.copyWith(status: GoalStatus.loading);

    try {
      final goal = await repository.getGoalById(id);

      state = state.copyWith(selectedGoal: goal, status: GoalStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: GoalStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateGoal(LearningGoal goal) async {
    try {
      await repository.updateGoal(goal);

      final updatedGoals = state.goals.map((item) {
        return item.id == goal.id ? goal : item;
      }).toList();

      state = state.copyWith(goals: updatedGoals, selectedGoal: goal);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> deleteGoal(String id) async {
    try {
      await repository.deleteGoal(id);

      final updatedGoals = state.goals.where((goal) => goal.id != id).toList();

      state = state.copyWith(goals: updatedGoals, selectedGoal: null);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
