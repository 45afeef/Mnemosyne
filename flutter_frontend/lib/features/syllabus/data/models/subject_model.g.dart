// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
  id: json['id'] as String? ?? const Uuid().v4(),
  name: json['name'] as String,
  description: json['description'] as String,
  modules: (json['modules'] as List<dynamic>)
      .map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'modules': instance.modules.map((e) => e.toJson()).toList(),
    };
