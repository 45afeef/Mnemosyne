import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/lesson_session_state.dart';
import '../providers/lesson_session_provider.dart';
import '../widgets/session_scaffold.dart';
import 'lesson_feedback_page.dart';

class LessonSessionPage extends ConsumerStatefulWidget {
  const LessonSessionPage({super.key});

  @override
  ConsumerState<LessonSessionPage> createState() => _LessonSessionPageState();
}

class _LessonSessionPageState extends ConsumerState<LessonSessionPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(lessonSessionControllerProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lessonSessionControllerProvider);

    return switch (state) {
      LessonSessionLoading() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      LessonSessionRunning() => const SessionScaffold(),

      LessonSessionGeneratingFeedback() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      LessonSessionCompleted() => LessonFeedbackPage(feedback: state.feedback),
    };
  }
}
