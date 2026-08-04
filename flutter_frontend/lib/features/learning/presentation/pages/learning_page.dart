import 'package:flutter/material.dart';

import '../../../lesson_session/domain/entities/session_step.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key, required this.step});

  final LearningStep step;

  @override
  Widget build(BuildContext context) {
    return Text(step.content.markdown);
  }
}
