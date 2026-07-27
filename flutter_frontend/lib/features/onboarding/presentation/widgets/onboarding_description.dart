import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            "Mnemosyne uses analogies, spatial mapping, and active recall to build long-term intuition and memory.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 100.ms)
        .slideY(begin: .08)
        .scale(begin: const Offset(.99, .99));
  }
}
