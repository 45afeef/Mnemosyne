import 'package:flutter_markdown/flutter_markdown.dart';

import 'models/lesson_block.dart';

class LessonMarkdownParser {
  const LessonMarkdownParser();

  static List<LessonBlock> parse(String markdown) {
    final lines = markdown.split('\n');

    final List<LessonBlock> blocks = [];

    final buffer = StringBuffer();

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Empty line means paragraph boundary
      if (line.trim().isEmpty) {
        _flushParagraph(buffer, blocks);
        continue;
      }

      // Heading
      if (line.startsWith('#')) {
        _flushParagraph(buffer, blocks);

        final level = line.split(' ').first.replaceAll('#', '').length;

        final text = line.replaceFirst(RegExp(r'^#+\s*'), '').trim();

        blocks.add(HeadingBlock(text: text, level: level));

        continue;
      }

      // Quote
      if (line.startsWith('>')) {
        _flushParagraph(buffer, blocks);

        blocks.add(QuoteBlock(markdown: line.replaceFirst('>', '').trim()));

        continue;
      }

      // Divider
      if (line.trim() == '---') {
        _flushParagraph(buffer, blocks);

        blocks.add(const DividerBlock());

        continue;
      }

      // Image
      final imageMatch = RegExp(r'!\[(.*?)\]\((.*?)\)').firstMatch(line);

      if (imageMatch != null) {
        _flushParagraph(buffer, blocks);

        blocks.add(
          ImageBlock(
            imageUrl: imageMatch.group(2)!,
            caption: imageMatch.group(1),
          ),
        );

        continue;
      }

      // Code block start
      if (line.startsWith('```')) {
        _flushParagraph(buffer, blocks);

        final language = line.replaceFirst('```', '').trim();

        final codeBuffer = StringBuffer();

        i++;

        while (i < lines.length && !lines[i].startsWith('```')) {
          codeBuffer.writeln(lines[i]);
          i++;
        }

        blocks.add(
          CodeBlock(
            code: codeBuffer.toString().trim(),
            language: language.isEmpty ? null : language,
          ),
        );

        continue;
      }

      // List
      if (_isListItem(line)) {
        _flushParagraph(buffer, blocks);

        final items = <String>[];

        while (i < lines.length && _isListItem(lines[i])) {
          items.add(lines[i].replaceFirst(RegExp(r'^[-*+]\s*'), '').trim());

          i++;
        }

        i--;

        blocks.add(ListBlock(items: items));

        continue;
      }

      buffer.writeln(line);
    }

    _flushParagraph(buffer, blocks);

    return blocks;
  }

  static void _flushParagraph(StringBuffer buffer, List<LessonBlock> blocks) {
    final text = buffer.toString().trim();

    if (text.isEmpty) {
      buffer.clear();
      return;
    }

    blocks.add(ParagraphBlock(markdown: text));

    buffer.clear();
  }

  static bool _isListItem(String line) {
    return RegExp(r'^[-*+]\s+').hasMatch(line);
  }
}
