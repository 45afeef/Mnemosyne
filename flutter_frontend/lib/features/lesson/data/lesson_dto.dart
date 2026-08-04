class LessonDto {
  const LessonDto({
    required this.id,
    required this.title,
    required this.content,
    required this.progress,
    this.assistantActions = const [],
  });
  final String id;
  final String title;

  /// Raw markdown received from server.
  final String content;
  final double progress;
  final List<LessonAssistantActionDto> assistantActions;
  factory LessonDto.fromJson(Map<String, dynamic> json) {
    return LessonDto(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      progress: (json['progress'] as num).toDouble(),
      assistantActions: (json['assistantActions'] as List<dynamic>? ?? [])
          .map(
            (item) =>
                LessonAssistantActionDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class LessonAssistantActionDto {
  const LessonAssistantActionDto({required this.label, this.type});
  final String label;
  final String? type;
  factory LessonAssistantActionDto.fromJson(Map<String, dynamic> json) {
    return LessonAssistantActionDto(
      label: json['label'] as String,
      type: json['type'] as String?,
    );
  }
}
