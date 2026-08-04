import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mnemosyne_learn/features/lesson_session/domain/entities/lesson_session.dart';
import 'package:mnemosyne_learn/features/lesson_session/domain/services/session_engine.dart';
import 'package:mnemosyne_learn/features/lesson_session/presentation/pages/session_entry_page.dart';
import 'package:mnemosyne_learn/features/lesson_session/presentation/providers/session_engine_provider.dart'
    show sessionEngineProvider;

import '../../domain/services/session_feedback_service.dart';
import '../controllers/lesson_session_controller.dart';
import '../controllers/lesson_session_state.dart';

final lessonSessionControllerProvider =
    StateNotifierProvider<LessonSessionController, LessonSessionState>((ref) {
      return LessonSessionController(
        engine: ref.watch(sessionEngineProvider),
        feedbackService: const SessionFeedbackService(),
      );
    });
