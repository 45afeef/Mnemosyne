import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/lesson_session/data/repository/lesson_session_repository_remote_impl.dart';
import '../../features/lesson_session/domain/repository/lesson_session_repository.dart';
import '../../features/syllabus/data/repositories/learning_goal_repository_impl.dart';
import '../../features/syllabus/data/repositories/syllabus_repository_remote_impl.dart';
import '../../features/syllabus/domain/repositories/goal_repository.dart';
import '../../features/syllabus/domain/repositories/syllabus_repository.dart';
import '../config.dart';
import '../data/app_api.dart';
import '../data/database_helper.dart';
import '../data/remote_api.dart';

final databaseHelperProvider = Provider((_) => DatabaseHelper.instance);

final appApiProvider = Provider<AppApi>((_) {
  // return DummyAppApi();
  return RemoteRestAppApi(baseUrl: Uri.parse(AppConfig.apiBaseUrl));
});

final learningGoalRepositoryProvider = Provider<LearningGoalRepository>((ref) {
  return LearningGoalRepositoryImpl(ref.read(databaseHelperProvider));
});

final syllabusRepositoryProvider = Provider<SyllabusRepository>((ref) {
  return SyllabusRepositoryRemoteImpl(
    ref.read(appApiProvider),
    ref.read(databaseHelperProvider),
  );
});

final lessonSessionRepositoryProvider = Provider<LessonSessionRepository>((
  ref,
) {
  return LessonSessionRepositoryRemoteImpl(
    ref.read(appApiProvider),
    ref.read(databaseHelperProvider),
  );
});
