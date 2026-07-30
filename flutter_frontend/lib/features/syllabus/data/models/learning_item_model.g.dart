// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningItemModel _$LearningItemModelFromJson(Map<String, dynamic> json) =>
    LearningItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      order: (json['order'] as num).toInt(),
      description: json['description'] as String,
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
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };
