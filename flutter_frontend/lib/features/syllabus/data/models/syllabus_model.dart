import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/syllabus.dart';
import 'subject_model.dart';

part 'syllabus_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SyllabusModel {
  final String id;
  final String title;
  final String description;
  final List<SubjectModel> subjects;

  const SyllabusModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjects,
  });

  Syllabus toEntity() {
    return Syllabus(
      id: id,
      title: title,
      description: description,
      subjects: subjects.map((e) => e.toEntity()).toList(),
    );
  }

  factory SyllabusModel.fromEntity(Syllabus entity) {
    return SyllabusModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      subjects: entity.subjects.map(SubjectModel.fromEntity).toList(),
    );
  }

  factory SyllabusModel.fromJson(Map<String, dynamic> json) =>
      _$SyllabusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusModelToJson(this);
}


