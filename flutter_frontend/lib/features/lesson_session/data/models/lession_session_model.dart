import 'package:uuid/uuid.dart';

import '../../../assessment/domain/entities/mcq.dart';
import '../../domain/entities/learning_content.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/entities/session_step.dart';
import '../../domain/entities/topic.dart';

class LessonSessionModel {
  const LessonSessionModel({
    required this.id,
    required this.topic,
    required this.lessonItems,
  });

  final String id;
  final String topic;
  final List<SessionLearningItemModel> lessonItems;

  factory LessonSessionModel.fromJson(Map<String, dynamic> json) {
    return LessonSessionModel(
      id: json['id'] as String? ?? const Uuid().v4(),
      topic: json['topic'] as String? ?? '',
      lessonItems:
          (json['lesson_items'] as List<dynamic>?)
              ?.map(
                (item) => SessionLearningItemModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'lesson_items': lessonItems.map((item) => item.toJson()).toList(),
    };
  }

  LessonSession toEntity() {
    final steps = <SessionStep>[];

    for (var itemIndex = 0; itemIndex < lessonItems.length; itemIndex++) {
      final item = lessonItems[itemIndex];

      if ((item.description ?? '').trim().isNotEmpty) {
        steps.add(
          LearningStep(
            id: _normalizeId('description_${itemIndex}_${item.name}'),
            title: item.name,
            content: LearningContent(
              id: _normalizeId('learning_${itemIndex}_${item.name}'),
              title: item.name,
              markdown: item.description!,
            ),
          ),
        );
      }

      for (
        var techniqueIndex = 0;
        techniqueIndex < item.techniques.length;
        techniqueIndex++
      ) {
        final technique = item.techniques[techniqueIndex];

        steps.add(
          LearningStep(
            id: _normalizeId(
              'technique_${itemIndex}_${techniqueIndex}_${technique.name}',
            ),
            title: technique.name,
            content: LearningContent(
              id: _normalizeId(
                'technique_content_${itemIndex}_${techniqueIndex}_${technique.name}',
              ),
              title: technique.name,
              markdown: technique.markdown,
            ),
          ),
        );
      }

      for (
        var assessmentIndex = 0;
        assessmentIndex < item.assessments.length;
        assessmentIndex++
      ) {
        final assessment = item.assessments[assessmentIndex];
        final assessmentStep = assessment.toSessionStep(
          itemIndex: itemIndex,
          assessmentIndex: assessmentIndex,
        );

        if (assessmentStep != null) {
          steps.add(assessmentStep);
        }
      }
    }

    return LessonSession(
      id: id,
      title: topic,
      topics: [
        Topic(id: _normalizeId('topic_$topic'), title: topic, steps: steps),
      ],
    );
  }
}

class SessionLearningItemModel {
  const SessionLearningItemModel({
    required this.name,
    this.description,
    required this.techniques,
    required this.assessments,
  });

  final String name;
  final String? description;
  final List<TechniqueContentModel> techniques;
  final List<AssessmentContentModel> assessments;

  factory SessionLearningItemModel.fromJson(Map<String, dynamic> json) {
    return SessionLearningItemModel(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      techniques:
          (json['techniques'] as List<dynamic>?)
              ?.map(
                (technique) => TechniqueContentModel.fromJson(
                  technique as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      assessments:
          (json['assessments'] as List<dynamic>?)
              ?.map(
                (assessment) => AssessmentContentModel.fromJson(
                  assessment as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'techniques': techniques.map((technique) => technique.toJson()).toList(),
      'assessments': assessments
          .map((assessment) => assessment.toJson())
          .toList(),
    };
  }
}

class TechniqueContentModel {
  const TechniqueContentModel({required this.name, required this.markdown});

  final String name;
  final String markdown;

  factory TechniqueContentModel.fromJson(Map<String, dynamic> json) {
    return TechniqueContentModel(
      name: json['name'] as String? ?? '',
      markdown: json['markdown'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'markdown': markdown};
  }
}

class AssessmentContentModel {
  const AssessmentContentModel({required this.name, required this.content});

  final String name;
  final Map<String, dynamic> content;

  factory AssessmentContentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentContentModel(
      name: json['name'] as String? ?? '',
      content: Map<String, dynamic>.from(json['content'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'content': content};
  }

  SessionStep? toSessionStep({
    required int itemIndex,
    required int assessmentIndex,
  }) {
    final question = content['question']?.toString() ?? name;
    final optionsData = content['options'] as List<dynamic>?;
    final explanation = content['explanation']?.toString();
    final answerValue = content['answer']?.toString();

    final options = <McqOption>[];

    if (optionsData != null) {
      for (final option in optionsData) {
        if (option is Map<String, dynamic>) {
          final id =
              option['id']?.toString() ??
              option['text']?.toString() ??
              option.toString();
          final text = option['text']?.toString() ?? option.toString();
          options.add(McqOption(id: id, text: text));
        } else {
          final text = option.toString();
          options.add(McqOption(id: text, text: text));
        }
      }
    }

    if (options.isEmpty) {
      return LearningStep(
        id: _normalizeId('assessment_${itemIndex}_${assessmentIndex}_$name'),
        title: name,
        content: LearningContent(
          id: _normalizeId(
            'assessment_content_${itemIndex}_${assessmentIndex}_$name',
          ),
          title: question,
          markdown: 'Question: $question',
        ),
      );
    }

    final correctOption = options.firstWhere(
      (option) => option.id == answerValue || option.text == answerValue,
      orElse: () => options.first,
    );

    return McqStep(
      id: _normalizeId('assessment_${itemIndex}_${assessmentIndex}_$name'),
      title: name,
      mcq: Mcq(
        id: _normalizeId('mcq_${itemIndex}_${assessmentIndex}_$name'),
        question: question,
        options: options,
        correctOptionId: correctOption.id,
        explanation: explanation,
      ),
    );
  }
}

String _normalizeId(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'_+'), '_');
}
