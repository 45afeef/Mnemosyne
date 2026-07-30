import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/subject.dart';
import 'module_model.dart';

part 'subject_model.g.dart';


@JsonSerializable(explicitToJson: true)
class SubjectModel {
  final String id;
  final String name;
  final int order;
  final List<ModuleModel> modules;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.order,
    required this.modules,
  });

  Subject toEntity() {
    return Subject(
      id: id,
      name: name,
      order: order,
      modules: modules.map((e) => e.toEntity()).toList(),
    );
  }

  factory SubjectModel.fromEntity(Subject entity) {
    return SubjectModel(
      id: entity.id,
      name: entity.name,
      order: entity.order,
      modules: entity.modules.map(ModuleModel.fromEntity).toList(),
    );
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
