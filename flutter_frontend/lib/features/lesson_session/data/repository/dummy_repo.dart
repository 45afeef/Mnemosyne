// import 'package:mnemosyne_learn/features/lesson/presentation/lesson_view_model.dart';
// import 'package:mnemosyne_learn/features/lesson_session/data/models/lession_session_model.dart';
// import 'package:mnemosyne_learn/features/lesson_session/data/repository/dummy_data.dart';
// import 'package:mnemosyne_learn/features/lesson_session/domain/repository/lesson_session_repository.dart';

// import '../../domain/entities/lesson_session.dart';

// class DummyRepo implements LessonSessionRepository {
//   @override
//   Future<void> completeSession(String id) {
//     // TODO: implement completeSession
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> deleteSession(String id) {
//     // TODO: implement deleteSession
//     throw UnimplementedError();
//   }

//   @override
//   Future<LessonSession> generateSession({
//     required List<String> learningItemIds,
//   }) async {
//     final lessonData = LessionSessionModel.fromJson(dummyLessonSession);

//     return lessonData as LessonSession;
//   }

//   @override
//   Future<LessonSession?> getSessionById(String id) {
//     // TODO: implement getSessionById
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<LessonSession>> getSessions() {
//     // TODO: implement getSessions
//     throw UnimplementedError();
//   }
// }
