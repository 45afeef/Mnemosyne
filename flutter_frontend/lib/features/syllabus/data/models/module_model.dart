import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/module.dart';
import 'learning_item_model.dart';

part 'module_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ModuleModel {
  final String id;
  final String name;
  final int order;
  final List<LearningItemModel> learningItems;

  const ModuleModel({
    required this.id,
    required this.name,
    required this.order,
    required this.learningItems,
  });

  Module toEntity() {
    return Module(
      id: id,
      name: name,
      order: order,
      learningItems: learningItems.map((e) => e.toEntity()).toList(),
    );
  }

  factory ModuleModel.fromEntity(Module entity) {
    return ModuleModel(
      id: entity.id,
      name: entity.name,
      order: entity.order,
      learningItems: entity.learningItems
          .map(LearningItemModel.fromEntity)
          .toList(),
    );
  }

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}
