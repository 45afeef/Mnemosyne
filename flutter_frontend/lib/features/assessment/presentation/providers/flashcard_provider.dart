import 'package:flutter_riverpod/legacy.dart';

import '../controllers/flashcard_controller.dart';
import '../controllers/flashcard_state.dart';

final flashcardControllerProvider =
    StateNotifierProvider.autoDispose<FlashcardController, FlashcardState>((
      ref,
    ) {
      return FlashcardController();
    });
