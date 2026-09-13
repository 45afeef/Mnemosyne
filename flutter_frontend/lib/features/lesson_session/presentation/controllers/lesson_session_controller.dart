import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../app/data/database_helper.dart';
import '../../../syllabus/domain/entities/syllabus.dart';
import '../../domain/entities/lesson_session.dart';
import '../../domain/entities/step_result.dart';
import '../../domain/repository/lesson_session_repository.dart';
import '../../domain/services/session_engine.dart';
import '../../domain/services/session_feedback_service.dart';
import '../states/lesson_session_state.dart';

class LessonSessionController extends StateNotifier<LessonSessionState> {
  LessonSessionController({
    required this.repository,
    required this.feedbackService,
    required this.databaseHelper,
    required this.getSyllabus,
  }) : super(const LessonSessionLoading());

  final LessonSessionRepository repository;
  final SessionFeedbackService feedbackService;
  final DatabaseHelper databaseHelper;

  final Syllabus? Function() getSyllabus;

  late SessionEngine engine;

  Future<void> start({List<String>? learningItemIds}) async {
    state = const LessonSessionLoading();

    try {
      final syllabus = getSyllabus();

      if (syllabus == null) {
        state = const LessonSessionFailed(error: 'No syllabus found');
        return;
      }

      LessonSession? session;

      if (learningItemIds != null && learningItemIds.isNotEmpty) {
        // Start the lesson session right now if the parameter 'learningItemIds' is provided
        session = await repository.generateSession(
          learningItemIds: learningItemIds,
        );
      } else {
        // This flow happens usually whent the user click the continue button in the homepage, 
        // This helps to minimize the cognitive load of where they left off
        // This helps to continue the lesson session from where the user is left off previously
        
        // Get the uncompleted lesson if it is generated previously
        session = await repository.getUncompletedSession();


        if (session == null) {
          // This happes only when the user hasn't started the new topic to learn, so it generates it 
          final nextIds = await _nextLearningItemIds(syllabus);

          if (nextIds.isEmpty) {
            state = const LessonSessionFailed(
              error: 'No session remaining in your syllabus',
            );
            return;
          }

          session = await repository.generateSession(learningItemIds: nextIds);
        }
      }

      engine = SessionEngine(session);

      state = LessonSessionRunning(
        currentStep: engine.currentStep,
        progress: engine.progress,
      );
    } catch (e, stackTrace) {
      debugPrint('LessonSession.start error: $e');
      debugPrintStack(stackTrace: stackTrace);

      state = LessonSessionFailed(error: e.toString());
    }
  }

  Future<List<String>> _nextLearningItemIds(Syllabus syllabus) async {
    final db = await databaseHelper.database;

    // Get all completed learning item IDs.
    final completedRows = await db.query(
      'lesson_sessions',
      columns: ['learning_item_ids'],
      where: 'is_completed = ?',
      whereArgs: [1],
    );

    final completedIds = <String>{};

    for (final row in completedRows) {
      final ids = jsonDecode(row['learning_item_ids'] as String);

      completedIds.addAll((ids as List).map((id) => id.toString()));
    }

    // Get the most recent incomplete session.
    final uncompletedRows = await db.query(
      'lesson_sessions',
      columns: ['learning_item_ids'],
      where: 'is_completed = ?',
      whereArgs: [0],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    // Resume the most recent unfinished session.
    if (uncompletedRows.isNotEmpty) {
      final ids = jsonDecode(
        uncompletedRows.first['learning_item_ids'] as String,
      );

      return (ids as List).map((id) => id.toString()).toList();
    }

    // Flatten all learning items in syllabus order.
    final learningItemIds = <String>[];

    for (final subject in syllabus.subjects) {
      for (final module in subject.modules) {
        for (final item in module.learningItems) {
          learningItemIds.add(item.id);
        }
      }
    }

    // Find the first item that hasn't been completed.
    for (final id in learningItemIds) {
      if (!completedIds.contains(id)) {
        return [id];
      }
    }

    // Everything is completed.
    return [];
  }

  void completeStep(StepResult result) {
    engine.completeStep(result);

    if (engine.isFinished) {
      completeSession();
      return;
    }

    state = LessonSessionRunning(
      currentStep: engine.currentStep,
      progress: engine.progress,
    );
  }

  Future<void> completeSession() async {
    state = const LessonSessionGeneratingFeedback();

    final result = engine.buildResult();
    final feedback = feedbackService.generate(result);

    await repository.completeSession(engine.session.id);

    state = LessonSessionCompleted(feedback: feedback);
  }

  void reset() {
    engine.reset();
    state = const LessonSessionLoading();
  }
}
