import 'dart:async';
import 'dart:math';

import '../../features/lesson_session/data/models/lession_session_model.dart';
import 'app_api.dart';

class DummyAppApi implements AppApi {
  @override
  Future<LessonSessionModel> generateLessonSession({
    required Map<String, dynamic> payload,
  }) async {
    // Simulate network delay.
    await Future.delayed(const Duration(milliseconds: 500));

    return LessonSessionModel.fromJson(DummyLessonSessionGenerator.generate());
  }

  @override
  Future<TechniqueContentModel> generateTechniqueItem({
    required String prompt,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return TechniqueContentModel.fromJson({
      'name': 'Dummy Technique',
      'markdown':
          '''

# $prompt

This is dummy technique content generated for testing.

## How to apply this technique

1. Identify the problem.
2. Break it into smaller parts.
3. Apply the technique.
4. Check the result.
5. Reflect on what could be improved.

This response is intentionally static and does not call a backend.
''',
    });
  }

  @override
  Future<AssessmentContentModel> generateAssessmentItem({
    required String prompt,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return AssessmentContentModel.fromJson({
      'name': 'Dummy Assessment',
      'content': {
        'question': prompt,
        'options': [
          {'id': 'option_a', 'text': 'Correct answer'},
          {'id': 'option_b', 'text': 'Incorrect answer'},
          {'id': 'option_c', 'text': 'Another incorrect answer'},
          {'id': 'option_d', 'text': 'Another option'},
        ],
        'answer': 'option_a',
        'explanation':
            'This is a dummy explanation used for testing the assessment flow.',
      },
    });
  }

  @override
  Future<Map<String, dynamic>> generateSyllabusFromGoal({
    required Map<String, dynamic> goalPayload,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return DummySyllabusGenerator.generate(goalPayload: goalPayload);
  }
}

class DummySyllabusGenerator {
  static final Random _random = Random();

  static const _titles = [
    'Flutter Developer Learning Path',
    'Advanced Flutter Development Journey',
    'Dart and Flutter Mastery',
    'Flutter Application Development Path',
    'Modern Flutter Engineering Roadmap',
    'Flutter Skills Development Program',
    'Complete Flutter Development Journey',
  ];

  static const _descriptions = [
    'A randomly generated learning path covering essential concepts and practical Flutter development skills.',
    'A comprehensive dummy syllabus designed to help learners build practical knowledge through structured lessons.',
    'A generated learning roadmap covering development fundamentals, architecture, state management, and practical application.',
    'A structured learning journey designed to progressively develop Flutter and Dart development skills.',
    'A dummy curriculum containing randomly generated subjects, modules, and learning activities.',
  ];

  static const _subjectNames = [
    'Flutter Fundamentals',
    'Dart Programming',
    'Flutter UI Development',
    'State Management',
    'Navigation and Routing',
    'Asynchronous Programming',
    'Data and Networking',
    'Application Architecture',
    'Testing and Quality',
    'Performance Optimization',
    'Advanced Flutter',
    'Practical Development',
  ];

  static const _moduleNames = [
    'Core Concepts',
    'Fundamentals',
    'Essential Techniques',
    'Practical Patterns',
    'Development Strategies',
    'Implementation Techniques',
    'Advanced Concepts',
    'Best Practices',
    'Real-World Applications',
    'Problem Solving',
    'Hands-on Practice',
    'Interview Preparation',
  ];

  static const _learningItemTitles = [
    'Understanding the Fundamentals',
    'Core Concepts',
    'Getting Started',
    'Working with Components',
    'Managing Application State',
    'Building Reusable Components',
    'Handling User Input',
    'Working with Async Data',
    'Error Handling',
    'Performance Optimization',
    'Code Organization',
    'Testing Strategies',
    'Debugging Techniques',
    'Architecture Patterns',
    'Practical Implementation',
    'Common Development Patterns',
    'Best Practices',
    'Real-World Scenarios',
    'Problem Solving Exercise',
    'Hands-on Practice',
  ];

  static const _learningItemDescriptions = [
    'Learn the fundamental concepts and understand how they are applied in real applications.',
    'Explore the key ideas behind this topic and learn when to use them.',
    'Understand the recommended approach and apply it through practical examples.',
    'Develop practical skills by working through common development scenarios.',
    'Learn how to implement this concept effectively in a Flutter application.',
    'Explore common patterns, techniques, and best practices related to this topic.',
    'Practice solving realistic problems using the concepts introduced in this module.',
    'Build confidence by applying the concept to a practical development scenario.',
  ];

  /// Generates a completely random dummy SyllabusModel.
  ///
  /// Every invocation creates a new:
  /// - syllabus ID
  /// - title
  /// - description
  /// - number of subjects
  /// - subjects
  /// - modules
  /// - learning items
  /// - learning item descriptions
  static Map<String, dynamic> generate({
    required Map<String, dynamic> goalPayload,
  }) {
    final subjectCount = _randomInt(2, 5);

    return {
      "id": _id('syllabus'),
      "title": "${_randomItem(_titles)} -- ${goalPayload['name']}",
      "description": _randomItem(_descriptions),
      "subjects": List.generate(
        subjectCount,
        (subjectIndex) => _generateSubject(subjectIndex),
      ),
    };
  }

  static Map<String, dynamic> _generateSubject(int subjectIndex) {
    final moduleCount = _randomInt(2, 5);

    return {
      "id": _id('subject'),
      "name": _randomItem(_subjectNames),
      "order": subjectIndex + 1,
      "modules": List.generate(
        moduleCount,
        (moduleIndex) => _generateModule(
          subjectIndex: subjectIndex,
          moduleIndex: moduleIndex,
        ),
      ),
    };
  }

  static Map<String, dynamic> _generateModule({
    required int subjectIndex,
    required int moduleIndex,
  }) {
    final learningItemCount = _randomInt(3, 6);

    return {
      "id": _id('module'),
      "name": _randomItem(_moduleNames),
      "order": moduleIndex + 1,
      "learningItems": List.generate(
        learningItemCount,
        (itemIndex) => _generateLearningItem(itemIndex),
      ),
    };
  }

  static Map<String, dynamic> _generateLearningItem(int itemIndex) {
    return {
      "id": _id('learning-item'),
      "title": _randomItem(_learningItemTitles),
      "description": _randomItem(_learningItemDescriptions),
      "order": itemIndex + 1,
    };
  }

  static String _id(String prefix) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final random = _random.nextInt(999999);

    return '$prefix-$timestamp-$random';
  }

  static T _randomItem<T>(List<T> items) {
    return items[_random.nextInt(items.length)];
  }

  static int _randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
}

class DummyLessonSessionGenerator {
  static final Random _random = Random();

  static const _topics = [
    'Flutter State Management',
    'Flutter Navigation',
    'Flutter Widgets',
    'Dart Async Programming',
    'Flutter Animations',
    'Flutter Forms',
    'Dart Null Safety',
    'Flutter Performance',
    'Flutter Layouts',
    'Flutter Testing',
  ];

  static const _concepts = [
    'Understanding State',
    'Managing State',
    'Widget Lifecycle',
    'Building Responsive UI',
    'Handling User Input',
    'Working with Async Data',
    'Error Handling',
    'Performance Optimization',
    'Code Organization',
    'Testing Flutter Apps',
  ];

  static const _techniques = [
    'State Identification',
    'State Lifting',
    'Dependency Injection',
    'Widget Composition',
    'Lazy Loading',
    'Event Handling',
    'Error Recovery',
    'Caching',
    'Input Validation',
    'Performance Profiling',
  ];

  static const _questions = [
    'What is the main purpose of this concept?',
    'Which approach is generally recommended?',
    'What should you consider when using this technique?',
    'Which option best describes this Flutter feature?',
    'What happens when this value changes?',
    'Which approach would be most appropriate here?',
  ];

  static const _optionTemplates = [
    'Keep the state close to where it is used',
    'Move everything into a single global object',
    'Create a separate application for each widget',
    'Avoid changing any application data',
    'Use the appropriate Flutter mechanism',
    'Store every value permanently',
    'Rebuild the entire application manually',
    'Remove the widget from the tree',
  ];

  static const _explanations = [
    'This approach keeps the implementation simple and makes the code easier to maintain.',
    'This is useful when multiple parts of an application need to coordinate around the same data.',
    'Flutter can use this approach to update the UI when application data changes.',
    'Keeping responsibilities separated makes the application easier to understand and test.',
    'The appropriate solution depends on how frequently the data changes and where it is needed.',
  ];

  /// Generates a completely random dummy lesson session.
  ///
  /// Every invocation creates different:
  /// - session ID
  /// - topic
  /// - lesson items
  /// - descriptions
  /// - techniques
  /// - assessments
  /// - questions
  /// - options
  /// - answers
  static Map<String, dynamic> generate() {
    final topic = _randomItem(_topics);

    return {
      'id': _id(),
      'topic': topic,
      'lesson_items': _generateLessonItems(),
    };
  }

  static List<Map<String, dynamic>> _generateLessonItems() {
    final count = _randomInt(2, 5);

    return List.generate(count, (_) => _generateLessonItem());
  }

  static Map<String, dynamic> _generateLessonItem() {
    final concept = _randomItem(_concepts);
    final techniqueCount = _randomInt(1, 3);

    return {
      'name': concept,
      'description': _generateDescription(concept),
      'techniques': List.generate(techniqueCount, (_) => _generateTechnique()),
      'assessments': [_generateAssessment()],
    };
  }

  static Map<String, dynamic> _generateTechnique() {
    final technique = _randomItem(_techniques);

    return {
      'name': technique,
      'markdown':
          '''
## $technique

This is a randomly generated learning technique.

The technique focuses on **$technique** and demonstrates how this concept can be applied when building Flutter applications.

### Key points

- Understand the purpose of the technique.
- Consider where it should be used.
- Keep the implementation simple.
- Test the behavior after making changes.

Example:

```dart
void example() {
  print("$technique");
}
```

''',
    };
  }

  static Map<String, dynamic> _generateAssessment() {
    final question = _randomItem(_questions);
    final options = List.generate(
      4,
      (index) => {
        'id': 'option_${String.fromCharCode(97 + index)}',
        'text': _randomItem(_optionTemplates),
      },
    );

    final answerIndex = _randomInt(0, options.length - 1);
    final answer = options[answerIndex];

    return {
      'name': '${_randomItem(_concepts)} Quiz',
      'content': {
        'question': question,
        'options': options,
        'answer': answer['id'],
        'explanation': _randomItem(_explanations),
      },
    };
  }

  static String _generateDescription(String concept) {
    return '''

$concept

This is randomly generated lesson content for $concept.

The purpose of this lesson is to provide placeholder educational content that can be used while testing the lesson generation flow.

Key ideas
Learn the fundamentals of $concept.
Understand when the concept should be used.
Apply the concept in a Flutter application.

Verify that the generated lesson is displayed correctly.
''';
  }

  static String _id() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final random = _random.nextInt(999999);

    return '$timestamp-$random';
  }

  static T _randomItem<T>(List<T> items) {
    return items[_random.nextInt(items.length)];
  }

  static int _randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
}
