import 'package:equatable/equatable.dart';
import 'module.dart';

class Subject extends Equatable {
  final String id;
  final String name;
  final int order;
  final List<Module> modules;

  const Subject({
    required this.id,
    required this.name,
    required this.order,
    this.modules = const [],
  });

  Subject copyWith({
    String? id,
    String? name,
    int? order,
    List<Module>? modules,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      modules: modules ?? this.modules,
    );
  }

  @override
  List<Object?> get props => [id, name, order, modules];
}
