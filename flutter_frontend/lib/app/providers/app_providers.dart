import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnemosyne_learn/app/database_helper.dart';
import 'package:mnemosyne_learn/features/syllabus/data/repositories/learning_goal_repository_impl.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/goal_repository.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/syllabus_repository.dart';

import '../../features/syllabus/data/data_source/syllabus_remote_datasource.dart';
import '../../features/syllabus/data/repositories/syllabus_repository_remote_impl.dart';

final databaseHelperProvider = Provider((_) => DatabaseHelper.instance);

final learningGoalRepositoryProvider = Provider<LearningGoalRepository>((ref) {
  return LearningGoalRepositoryImpl(ref.watch(databaseHelperProvider));
});


final syllabusRepositoryProvider = Provider<SyllabusRepository>((ref) {
  return SyllabusRepositoryRemoteImpl(
    SyllabusRemoteDataSourceImpl(),
    ref.watch(databaseHelperProvider),
  );
});
