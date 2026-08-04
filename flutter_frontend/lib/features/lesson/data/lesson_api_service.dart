import 'lesson_dto.dart';

abstract interface class LessonApiService {
  Future<LessonDto> fetchLesson(String lessonId);
}

class LessonApiServiceImpl implements LessonApiService {
  LessonApiServiceImpl({this.client});

  final LessonHttpClient? client;

  @override
  Future<LessonDto> fetchLesson(String lessonId) async {
    // final response = await client.get("/lessons/$lessonId");

    // return LessonDto.fromJson(response);
    throw UnimplementedError();
  }
}

/// Temporary abstraction.
/// Replace this with Dio, Http, Retrofit, etc.
abstract interface class LessonHttpClient {
  Future<Map<String, dynamic>> get(String path);
}
