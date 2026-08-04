import 'package:flutter_riverpod/legacy.dart';

import '../controllers/flashcard_controller.dart';
import '../controllers/flashcard_state.dart';

final flashcardControllerProvider =
    StateNotifierProvider<FlashcardController, FlashcardState>((ref) {
      return FlashcardController();
    });
