// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel(
  id: json['id'] as String? ?? const Uuid().v4(),
  name: json['name'] as String,
  description: json['description'] as String,
  learningItems: (json['learning_items'] as List<dynamic>)
      .map((e) => LearningItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ModuleModelToJson(ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'learning_items': instance.learningItems.map((e) => e.toJson()).toList(),
    };
