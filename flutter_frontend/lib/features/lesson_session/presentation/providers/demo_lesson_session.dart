import '../../../assessment/domain/entities/flashcard.dart';
import '../../../assessment/domain/entities/mcq.dart';
import '../../../learning/domain/entities/learning_content.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/entities/session_step.dart';
import '../../domain/entities/topic.dart';

final demoLessonSession = LessonSession(
  id: 'session_1',
  title: 'Introduction Session',
  topics: [
    Topic(
      id: 'topic_1',
      title: 'Basics',
      steps: [
        LearningStep(
          id: 'learning_1',
          title: 'Introduction',
          content: LearningContent(
            id: 'content_1',
            title: 'What is Flutter?',
            markdown: '''
# Flutter

Flutter is a UI toolkit for building apps.

It allows developers to create beautiful applications
from a single codebase.
''',
          ),
        ),
        McqStep(
          id: 'mcq_1',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is Flutter?',
            options: [
              McqOption(id: 'a', text: 'A UI toolkit'),
              McqOption(id: 'b', text: 'A database'),
              McqOption(id: 'c', text: 'An operating system'),
            ],
            correctOptionId: 'a',
            explanation: 'Flutter is a UI toolkit by Google.',
          ),
        ),
        FlashcardStep(
          id: 'flashcard_1',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Flutter',
            back: 'A framework for building cross-platform apps.',
          ),
        ),
        McqStep(
          id: 'mcq_2',
          title: 'Quick Check',
          mcq: Mcq(
            id: 'mcq_1',
            question: 'What is Flutter?',
            options: [
              McqOption(id: 'a', text: 'A'),
              McqOption(id: 'b', text: 'B'),
              McqOption(id: 'c', text: 'C'),
            ],
            correctOptionId: 'a',
            explanation: 'Flutter is a UI toolkit by Google.',
          ),
        ),
        FlashcardStep(
          id: 'flashcard_2',
          title: 'Remember',
          flashcard: Flashcard(
            id: 'card_1',
            front: 'Flutter',
            back: 'A framework for building cross-platform apps.',
          ),
        ),
      ],
    ),
  ],
);
