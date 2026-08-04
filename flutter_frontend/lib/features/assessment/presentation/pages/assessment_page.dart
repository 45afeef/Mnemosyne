import 'package:flutter/material.dart';

import '../../../lesson_session/domain/entities/session_step.dart';
import '../widgets/assessment_host.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key, required this.step});

  final SessionStep step;

  @override
  Widget build(BuildContext context) {
    return AssessmentHost(step: step);
  }
}
