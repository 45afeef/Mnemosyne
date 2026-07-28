import 'package:equatable/equatable.dart';

class LearningGoal extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime? endDate;
  final Duration? dailyCommitment;
  final DateTime createdAt;

  const LearningGoal({
    required this.id,
    required this.name,
    this.description,
    this.endDate,
    this.dailyCommitment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    endDate,
    dailyCommitment,
    createdAt,
  ];

  LearningGoal copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? endDate,
    Duration? dailyCommitment,
    DateTime? createdAt,
  }) => LearningGoal(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    endDate: endDate ?? this.endDate,
    dailyCommitment: dailyCommitment ?? this.dailyCommitment,
    createdAt: createdAt ?? this.createdAt,
  );
}
