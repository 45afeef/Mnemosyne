import 'package:equatable/equatable.dart';
import 'subject.dart';

class Syllabus extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<Subject> subjects;

  const Syllabus({
    required this.id,
    required this.title,
    required this.description,
    this.subjects = const [],
  });

  Syllabus copyWith({
    String? id,
    String? title,
    String? description,
    List<Subject>? subjects,
  }) {
    return Syllabus(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  List<Object?> get props => [id, title, description, subjects];
}
