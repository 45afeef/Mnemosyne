enum LearningSessionItemKind { firstTime, reviewing, prerequisite }

class LessonItem {
  final LearningSessionItemKind kind;
  final String name;
  final String description;
  final List<ItemAssessment> assessments;
  final List<ItemContent> techniques;

  LessonItem({
    this.kind = .firstTime,
    required this.name,
    required this.description,
    required this.assessments,
    required this.techniques,
  });
}

class ItemAssessment {
  final String type;
  final String question;
  final List<String> options;
  final String answer;
  final String explanation;

  ItemAssessment({
    required this.type,
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });
}

class ItemContent {
  final String name;
  final String markdown;

  ItemContent({required this.name, required this.markdown});
}
