// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel(
  id: json['id'] as String,
  name: json['name'] as String,
  order: (json['order'] as num).toInt(),
  learningItems: (json['learningItems'] as List<dynamic>)
      .map((e) => LearningItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ModuleModelToJson(ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'learningItems': instance.learningItems.map((e) => e.toJson()).toList(),
    };
