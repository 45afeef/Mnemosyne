import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/mcq.dart';
import '../controllers/mcq_controller.dart';
import '../controllers/mcq_state.dart';

final mcqControllerProvider =
    StateNotifierProvider.family<McqController, McqState, Mcq>((ref, mcq) {
      return McqController(mcq: mcq);
    });
