import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/subject.dart';
import 'module_model.dart';

part 'subject_model.g.dart';


@JsonSerializable(explicitToJson: true)
class SubjectModel {
  final String id;
  final String name;
  final String description;
  final List<ModuleModel> modules;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.modules,
  });

  Subject toEntity() {
    return Subject(
      id: id,
      name: name,
      description: description,
      modules: modules.map((e) => e.toEntity()).toList(),
    );
  }

  factory SubjectModel.fromEntity(Subject entity) {
    return SubjectModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      modules: entity.modules.map(ModuleModel.fromEntity).toList(),
    );
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
