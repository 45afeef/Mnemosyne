import '../entities/lesson_session.dart';
import '../entities/session_result.dart';
import '../entities/session_step.dart';
import '../entities/step_result.dart';
import '../entities/topic.dart';

class SessionEngine {
  SessionEngine(this.session);

  final LessonSession session;

  int _currentTopicIndex = 0;
  int _currentStepIndex = 0;

  final List<StepResult> _results = [];

  Topic get currentTopic => session.topics[_currentTopicIndex];

  SessionStep get currentStep => currentTopic.steps[_currentStepIndex];

  List<StepResult> get results => List.unmodifiable(_results);

  bool get isFinished =>
      _currentTopicIndex == session.topics.length - 1 &&
      _currentStepIndex == currentTopic.steps.length - 1;

  double get progress {
    final total = session.topics.fold<int>(
      0,
      (sum, topic) => sum + topic.steps.length,
    );

    final completed = _results.length;

    return total == 0 ? 0 : completed / total;
  }

  void completeStep(StepResult result) {
    _results.add(result);

    if (_currentStepIndex < currentTopic.steps.length - 1) {
      _currentStepIndex++;
      return;
    }

    if (_currentTopicIndex < session.topics.length - 1) {
      _currentTopicIndex++;
      _currentStepIndex = 0;
    }
  }

  SessionResult buildResult() {
    return SessionResult(
      sessionId: session.id,
      stepResults: results,
      completedAt: DateTime.now(),
    );
  }
}
