import 'package:equatable/equatable.dart';

import 'module.dart';

class Subject extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<Module> modules;

  const Subject({
    required this.id,
    required this.name,
    required this.description,
    this.modules = const [],
  });

  Subject copyWith({
    String? id,
    String? name,
    String? description,
    List<Module>? modules,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      modules: modules ?? this.modules,
    );
  }

  @override
  List<Object?> get props => [id, name, description, modules];
}
