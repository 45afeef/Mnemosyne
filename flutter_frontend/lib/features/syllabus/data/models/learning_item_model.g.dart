// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningItemModel _$LearningItemModelFromJson(Map<String, dynamic> json) =>
    LearningItemModel(
      id: json['id'] as String? ?? const Uuid().v4(),
      title: json['name'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      children:
          (json['children'] as List<dynamic>?)
              ?.map(
                (e) => LearningItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LearningItemModelToJson(LearningItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'description': instance.description,
      'content': instance.content,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };
