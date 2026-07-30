// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
  id: json['id'] as String,
  name: json['name'] as String,
  order: (json['order'] as num).toInt(),
  modules: (json['modules'] as List<dynamic>)
      .map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'modules': instance.modules.map((e) => e.toJson()).toList(),
    };
