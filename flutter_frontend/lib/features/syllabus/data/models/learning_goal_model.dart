import '../../domain/entities/learning_goal.dart';

class LearningGoalModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? endDate;
  final Duration? dailyCommitment;
  final DateTime createdAt;

  const LearningGoalModel({
    required this.id,
    required this.name,
    this.description,
    this.endDate,
    this.dailyCommitment,
    required this.createdAt,
  });

  factory LearningGoalModel.fromMap(Map<String, dynamic> map) {
    return LearningGoalModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      dailyCommitment: map['daily_commitment'] != null
          ? Duration(minutes: map['daily_commitment'])
          : null,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'end_date': endDate?.toIso8601String(),
      'daily_commitment': dailyCommitment?.inMinutes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  LearningGoal toEntity() {
    return LearningGoal(
      id: id,
      name: name,
      description: description,
      endDate: endDate,
      dailyCommitment: dailyCommitment,
      createdAt: createdAt,
    );
  }

  factory LearningGoalModel.fromEntity(LearningGoal entity) {
    return LearningGoalModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      endDate: entity.endDate,
      dailyCommitment: entity.dailyCommitment,
      createdAt: entity.createdAt,
    );
  }
}
