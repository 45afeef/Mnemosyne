import '../../domain/entities/learning_session_item.dart';
import '../../domain/entities/lesson_session_old.dart';

class LessionSessionModel extends LessonSessionOld {
  LessionSessionModel({
    super.id = "",
    required super.topicName,
    required super.learningItems,
  });

  factory LessionSessionModel.fromJson(Map<String, dynamic> json) {
    return LessionSessionModel(
      id: json['id'] as String,
      topicName: json['topic'] as String,
      learningItems: (json['lesson_items'] as List<dynamic>)
          .map(
            (item) => LessonItem(
              name: item['name'] as String,
              description: item['description'] as String,
              techniques: (item['techniques'] as List<dynamic>)
                  .map(
                    (technique) => ItemContent(
                      name: technique['name'] as String,
                      markdown: technique['markdown'] as String,
                    ),
                  )
                  .toList(),
              assessments: (item['assessment'] as List<dynamic>).map((
                assessment,
              ) {
                final content = assessment['content'] as Map<String, dynamic>;

                return ItemAssessment(
                  type: assessment['name'] as String,
                  question: content['question'] as String,
                  options: List<String>.from(content['options'] as List),
                  answer: content['answer'],
                  explanation: content['explanation'] as String,
                );
              }).toList(),
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'topic': topicName,
    'lesson_items': learningItems
        .map(
          (i) => {
            "name": i.name,
            "description": i.description,
            "techniques": i.techniques
                .map((t) => {"name": t.name, "markdown": t.markdown})
                .toList(),
            "assessment": i.assessments
                .map(
                  (a) => {
                    "name": a.type,
                    "content": {
                      "question": a.question,
                      "options": a.options,
                      "answer": a.answer,
                      "explanation": a.explanation,
                    },
                  },
                )
                .toList(),
          },
        )
        .toList(),
  };
}
