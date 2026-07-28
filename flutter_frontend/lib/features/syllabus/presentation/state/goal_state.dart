import 'package:equatable/equatable.dart';
import '../../domain/entities/learning_goal.dart';
import 'goal_status.dart';

class GoalState extends Equatable {
  final List<LearningGoal> goals;

  final LearningGoal? draftGoal;

  final LearningGoal? selectedGoal;

  final GoalStatus status;

  final String? errorMessage;

  const GoalState({
    this.goals = const [],
    this.draftGoal,
    this.selectedGoal,
    this.status = GoalStatus.initial,
    this.errorMessage,
  });

  GoalState copyWith({
    List<LearningGoal>? goals,
    LearningGoal? draftGoal,
    LearningGoal? selectedGoal,
    GoalStatus? status,
    String? errorMessage,
  }) {
    return GoalState(
      goals: goals ?? this.goals,
      draftGoal: draftGoal ?? this.draftGoal,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    goals,
    draftGoal,
    selectedGoal,
    status,
    errorMessage,
  ];
}
