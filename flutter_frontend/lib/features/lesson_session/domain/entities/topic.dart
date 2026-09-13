import 'session_step.dart';

class Topic {
  const Topic({required this.id, required this.title, required this.steps});

  final String id;

  final String title;

  final List<SessionStep> steps;
}
