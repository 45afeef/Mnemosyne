import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_buttons.dart';

class LessonBottomAction extends StatelessWidget {
  const LessonBottomAction({
    super.key,
    required this.hasMore,
    required this.onPressed,
  });

  final bool hasMore;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryCTAButton(
          text: hasMore ? 'Continue' : 'Next Concept',
          icon: hasMore
              ? Icons.keyboard_arrow_down_rounded
              : Icons.arrow_forward_rounded,
          onPressed: onPressed,
        )
        .animate(key: ValueKey(hasMore))
        .fadeIn(duration: 250.ms)
        .slideY(begin: 0.15, end: 0, duration: 250.ms, curve: Curves.easeOut);
  }
}
