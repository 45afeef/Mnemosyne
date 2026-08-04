import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/session_engine.dart';
import 'demo_lesson_session.dart';

final sessionEngineProvider = Provider<SessionEngine>((ref) {
  return SessionEngine(demoLessonSession);
});
