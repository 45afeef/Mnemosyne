import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/learning_item.dart';

part 'learning_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LearningItemModel {
  final String id;
  final String title;
  final String description;
  final String content;
  final List<LearningItemModel> children;

  const LearningItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    this.children = const [],
  });

  LearningItem toEntity() {
    return LearningItem(
      id: id,
      title: title,
      description: description,
      content: content,
      children: children.map((e) => e.toEntity()).toList(),
    );
  }

  factory LearningItemModel.fromEntity(LearningItem entity) {
    return LearningItemModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      content: entity.content,
      children: entity.children.map(LearningItemModel.fromEntity).toList(),
    );
  }
  factory LearningItemModel.fromJson(Map<String, dynamic> json) =>
      _$LearningItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LearningItemModelToJson(this);
}
