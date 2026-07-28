import 'package:flutter_riverpod/legacy.dart';

import '../notifier/syllabus_notifier.dart';
import '../state/syllabus_state.dart';
import '../../../../app/providers/app_providers.dart';

final syllabusNotifierProvider =
    StateNotifierProvider<SyllabusNotifier, SyllabusState>((ref) {
      final repository = ref.watch(syllabusRepositoryProvider);

      return SyllabusNotifier(repository);
    });
