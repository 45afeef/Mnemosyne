import 'package:flutter_riverpod/legacy.dart';

import '../../../../app/providers/app_providers.dart';
import '../notifier/syllabus_notifier.dart';
import '../state/syllabus_state.dart';

final syllabusNotifierProvider =
    StateNotifierProvider<SyllabusNotifier, SyllabusState>((ref) {
      final repository = ref.read(syllabusRepositoryProvider);
      final goalRepo = ref.read(learningGoalRepositoryProvider);

      return SyllabusNotifier(repository, goalRepo);
    });
