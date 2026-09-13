/// Represents a single piece of learning content.
///
/// This entity is intentionally presentation-agnostic.
/// The session engine doesn't care *how* the content is rendered,
/// only that a LearningStep references it.
class LearningContent {
  const LearningContent({
    required this.id,
    required this.title,
    required this.markdown,
  });

  /// Unique identifier.
  final String id;

  /// Display title.
  final String title;

  /// Markdown source.
  ///
  /// Your existing animated markdown widget is responsible for rendering this.
  final String markdown;
}