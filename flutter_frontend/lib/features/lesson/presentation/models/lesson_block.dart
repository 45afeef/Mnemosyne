import 'package:flutter/foundation.dart';

/// Base class for all renderable lesson blocks.
///
/// The markdown parser converts the server response into a list of
/// [LessonBlock]s. The UI renders these one by one using the
/// progressive reveal controller.
@immutable
sealed class LessonBlock {
  const LessonBlock();
}

/// ---------------------------------------------------------------------------
/// Heading
/// ---------------------------------------------------------------------------

final class HeadingBlock extends LessonBlock {
  const HeadingBlock({required this.text, this.level = 1});

  final String text;

  /// Markdown heading level (1-6)
  final int level;
}

/// ---------------------------------------------------------------------------
/// Paragraph
/// ---------------------------------------------------------------------------

final class ParagraphBlock extends LessonBlock {
  const ParagraphBlock({required this.markdown});

  /// Supports inline markdown like:
  /// **bold**, *italic*, `code`, [links]()
  final String markdown;
}

/// ---------------------------------------------------------------------------
/// Quote
/// ---------------------------------------------------------------------------

final class QuoteBlock extends LessonBlock {
  const QuoteBlock({required this.markdown});

  final String markdown;
}

/// ---------------------------------------------------------------------------
/// Bullet / Ordered List
/// ---------------------------------------------------------------------------

final class ListBlock extends LessonBlock {
  const ListBlock({required this.items, this.ordered = false});

  final List<String> items;
  final bool ordered;
}

/// ---------------------------------------------------------------------------
/// Code
/// ---------------------------------------------------------------------------

final class CodeBlock extends LessonBlock {
  const CodeBlock({required this.code, this.language});

  final String code;
  final String? language;
}

/// ---------------------------------------------------------------------------
/// Image
/// ---------------------------------------------------------------------------

final class ImageBlock extends LessonBlock {
  const ImageBlock({required this.imageUrl, this.caption});

  final String imageUrl;
  final String? caption;
}

/// ---------------------------------------------------------------------------
/// Divider
/// ---------------------------------------------------------------------------

final class DividerBlock extends LessonBlock {
  const DividerBlock();
}

/// ---------------------------------------------------------------------------
/// Callout / Tip
/// ---------------------------------------------------------------------------

enum CalloutType { info, success, warning, error }

final class CalloutBlock extends LessonBlock {
  const CalloutBlock({required this.type, required this.markdown});

  final CalloutType type;
  final String markdown;
}
