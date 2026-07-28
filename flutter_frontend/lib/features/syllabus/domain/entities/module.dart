import 'package:equatable/equatable.dart';
import 'learning_item.dart';

class Module extends Equatable {
  final String id;
  final String name;
  final int order;
  final List<LearningItem> learningItems;

  const Module({
    required this.id,
    required this.name,
    required this.order,
    this.learningItems = const [],
  });

  Module copyWith({
    String? id,
    String? name,
    int? order,
    List<LearningItem>? learningItems,
  }) {
    return Module(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      learningItems: learningItems ?? this.learningItems,
    );
  }

  @override
  List<Object?> get props => [id, name, order, learningItems];
}
