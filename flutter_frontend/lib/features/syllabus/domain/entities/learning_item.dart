import 'package:equatable/equatable.dart';

class LearningItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final List<LearningItem> children;

  const LearningItem({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    this.children = const [],
  });

  LearningItem copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    List<LearningItem>? children,
  }) {
    return LearningItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      children: children ?? this.children,
    );
  }

  bool get hasChildren => children.isNotEmpty;

  int get totalChildrenCount {
    return children.fold(
      children.length,
      (sum, item) => sum + item.totalChildrenCount,
    );
  }

  @override
  List<Object?> get props => [id, title, description, content, children];
}
