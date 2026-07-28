import 'package:flutter_riverpod/legacy.dart';

import '../../../../app/providers/app_providers.dart';
import '../notifier/goal_notifier.dart';
import '../state/goal_state.dart';

final goalNotifierProvider = StateNotifierProvider<GoalNotifier, GoalState>((
  ref,
) {
  final repository = ref.watch(learningGoalRepositoryProvider);

  return GoalNotifier(repository);
});
