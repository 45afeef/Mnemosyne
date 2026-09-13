// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syllabus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyllabusModel _$SyllabusModelFromJson(Map<String, dynamic> json) =>
    SyllabusModel(
      id: json['id'] as String? ?? const Uuid().v4(),
      title: json['title'] as String,
      description: json['description'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyllabusModelToJson(SyllabusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'subjects': instance.subjects.map((e) => e.toJson()).toList(),
    };
