import 'dart:convert';

import 'lession_session_model.dart';

class LessonSessionStorageModel {
  const LessonSessionStorageModel({
    required this.id,
    this.learingItemIDs = "",
    required this.topic,
    required this.content,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String topic;
  final String content;
  final bool isCompleted;
  final int createdAt;
  final int updatedAt;
  final String learingItemIDs;

  factory LessonSessionStorageModel.fromSessionModel(LessonSessionModel model) {
    final now = DateTime.now().millisecondsSinceEpoch;

    return LessonSessionStorageModel(
      id: model.id,
      topic: model.topic,
      content: jsonEncode(model.toJson()),
      isCompleted: false,
      createdAt: now,
      updatedAt: now,
    );
  }

  factory LessonSessionStorageModel.fromMap(Map<String, Object?> map) {
    return LessonSessionStorageModel(
      id: map['id'] as String,
      topic: map['topic'] as String,
      content: map['content'] as String,
      isCompleted: (map['is_completed'] as int) == 1,
      createdAt: map['created_at'] as int,
      updatedAt: map['updated_at'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'topic': topic,
      'content': content,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'learning_item_ids': learingItemIDs,
    };
  }

  LessonSessionStorageModel copyWith({
    String? id,
    String? topic,
    String? content,
    bool? isCompleted,
    String? learingItemIDs,
    int? createdAt,
    int? updatedAt,
  }) {
    return LessonSessionStorageModel(
      id: id ?? this.id,
      learingItemIDs: learingItemIDs ?? this.learingItemIDs,
      topic: topic ?? this.topic,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
