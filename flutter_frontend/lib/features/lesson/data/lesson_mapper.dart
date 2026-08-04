import '../presentation/lesson_markdown_parser.dart';
import '../domain/entities/lesson.dart';
import '../presentation/models/lesson_block.dart';
import 'lesson_dto.dart';

class LessonMapper {
  const LessonMapper({this._parser = const LessonMarkdownParser()});
  final LessonMarkdownParser _parser;

  Lesson map(LessonDto dto) {
    final List<LessonBlock> blocks = _parser.parse(dto.content);
    return Lesson(
      id: dto.id,
      title: dto.title,
      progress: dto.progress,
      blocks: blocks,
      assistantActions: dto.assistantActions
          .map(
            (action) => LessonAssistantAction(
              label: action.label,
              actionType: action.type,
            ),
          )
          .toList(),
    );
  }
}
