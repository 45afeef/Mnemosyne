import 'package:flutter_riverpod/legacy.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../syllabus/presentation/provider/syllabus_provider.dart';
import '../../domain/services/session_feedback_service.dart';
import '../controllers/lesson_session_controller.dart';
import '../states/lesson_session_state.dart';

final lessonSessionControllerProvider =
    StateNotifierProvider<LessonSessionController, LessonSessionState>((ref) {
      return LessonSessionController(
        repository: ref.read(lessonSessionRepositoryProvider),
        feedbackService: const SessionFeedbackService(),
        databaseHelper: ref.read(databaseHelperProvider),
        getSyllabus: () {
          return ref.read(syllabusNotifierProvider).syllabus;
        },
      );
    });
