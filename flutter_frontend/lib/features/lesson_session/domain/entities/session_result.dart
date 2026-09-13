import 'step_result.dart';

class SessionResult {
  const SessionResult({
    required this.sessionId,
    required this.stepResults,
    required this.completedAt,
  });

  final String sessionId;

  final List<StepResult> stepResults;

  final DateTime completedAt;

  int get totalSteps => stepResults.length;
}
