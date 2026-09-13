import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../syllabus/presentation/provider/syllabus_provider.dart';
import '../../../syllabus/presentation/state/syllabus_state.dart';
import '../../../syllabus/presentation/state/syllabus_status.dart';
import '../providers/lesson_session_provider.dart';
import '../states/lesson_session_state.dart';
import '../widgets/session_scaffold.dart';
import 'topic_completion_page.dart';

class LessonSessionPage extends ConsumerStatefulWidget {
  const LessonSessionPage({super.key, this.learningItemIds});

  final List<String>? learningItemIds;

  @override
  ConsumerState<LessonSessionPage> createState() => _LessonSessionPageState();
}

class _LessonSessionPageState extends ConsumerState<LessonSessionPage> {
  bool _sessionStartRequested = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => _tryStartLessonSession(widget.learningItemIds));
  }

  void _tryStartLessonSession(List<String>? learningItemIds) {
    if (!mounted || _sessionStartRequested) {
      return;
    }

    final syllabusState = ref.read(syllabusNotifierProvider);

    if (syllabusState.status != SyllabusStatus.ready) {
      return;
    }

    if (syllabusState.syllabus == null) {
      return;
    }

    _sessionStartRequested = true;

    ref
        .read(lessonSessionControllerProvider.notifier)
        .start(learningItemIds: learningItemIds);
  }

  @override
  Widget build(BuildContext context) {
    final syllabusState = ref.watch(syllabusNotifierProvider);

    ref.listen<SyllabusState>(syllabusNotifierProvider, (previous, next) {
      if (next.status == SyllabusStatus.ready && next.syllabus != null) {
        _tryStartLessonSession(widget.learningItemIds);
      }
    });

    // Syllabus is still loading.
    if (syllabusState.status == SyllabusStatus.initial ||
        syllabusState.status == SyllabusStatus.loading ||
        syllabusState.status == SyllabusStatus.generating) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Syllabus failed to load.
    if (syllabusState.status == SyllabusStatus.error) {
      return Scaffold(
        body: Center(
          child: Text(syllabusState.errorMessage ?? 'Failed to load syllabus'),
        ),
      );
    }

    // Syllabus finished loading but doesn't exist.
    if (syllabusState.status == SyllabusStatus.ready &&
        syllabusState.syllabus == null) {
      return const Scaffold(body: Center(child: Text('No syllabus found')));
    }

    final lessonState = ref.watch(lessonSessionControllerProvider);

    // Syllabus is ready, now display lesson-session state.
    return switch (lessonState) {
      LessonSessionLoading() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      LessonSessionRunning() => const SessionScaffold(),

      LessonSessionGeneratingFeedback() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      LessonSessionCompleted() => TopicCompletionPage(
        feedback: lessonState.feedback,
      ),

      LessonSessionFailed() => Scaffold(
        body: Center(child: Text(lessonState.error)),
      ),
    };
  }
}
