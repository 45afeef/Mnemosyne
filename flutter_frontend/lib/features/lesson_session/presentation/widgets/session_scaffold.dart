import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/widgets/app_progress_bar.dart';
import '../providers/lesson_session_provider.dart';
import '../states/lesson_session_state.dart';
import 'step_host.dart';

class SessionScaffold extends ConsumerWidget {
  const SessionScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actualProgress =
        (ref.watch(lessonSessionControllerProvider) as LessonSessionRunning)
            .progress
            .clamp(0.0, 1.0);

    final visualProgress = 0.06 + (actualProgress * 0.94);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppProgressBar(progress: visualProgress),

            const Expanded(child: StepHost()),
          ],
        ),
      ),
    );
  }
}
