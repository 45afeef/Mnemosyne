import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const OnboardingBackground(),

          SafeArea(
            child: Center(
              child: const OnboardingContent()
                  .animate()
                  // Beautiful subtle entrance
                  .fadeIn(duration: 900.ms, curve: Curves.easeOutExpo)
                  .slideY(
                    begin: .08,
                    end: 0,
                    duration: 900.ms,
                    curve: Curves.easeOutExpo,
                  )
                  .scale(
                    begin: const Offset(.97, .97),
                    end: const Offset(1, 1),
                    duration: 900.ms,
                    curve: Curves.easeOutExpo,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

