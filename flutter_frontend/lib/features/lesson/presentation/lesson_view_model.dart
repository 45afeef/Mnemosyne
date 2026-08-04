import 'package:flutter/foundation.dart';

import '../domain/entities/lesson.dart';
import '../domain/repository/lesson_repository.dart';

enum LessonLoadState { idle, loading, loaded, error }

class LessonViewModel extends ChangeNotifier {
  LessonViewModel({required this.repository});

  final LessonRepository repository;

  LessonLoadState _state = LessonLoadState.idle;

  LessonLoadState get state => _state;

  Lesson? _lesson;

  Lesson? get lesson => _lesson;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loadLesson(String lessonId) async {
    try {
      _state = LessonLoadState.loading;

      _errorMessage = null;

      notifyListeners();

      final result = await repository.getLesson(lessonId);

      _lesson = result;

      _state = LessonLoadState.loaded;
    } catch (e) {
      _state = LessonLoadState.error;

      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void clear() {
    _lesson = null;

    _errorMessage = null;

    _state = LessonLoadState.idle;

    notifyListeners();
  }
}
