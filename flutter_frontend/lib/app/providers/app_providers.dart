import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnemosyne_learn/app/database_helper.dart';
import 'package:mnemosyne_learn/features/syllabus/data/repositories/learning_goal_repository_impl.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/goal_repository.dart';

final databaseHelperProvider = Provider((_) => DatabaseHelper.instance);

final learningGoalRepositoryProvider = Provider<LearningGoalRepository>((ref) {
  return LearningGoalRepositoryImpl(ref.watch(databaseHelperProvider));
});
