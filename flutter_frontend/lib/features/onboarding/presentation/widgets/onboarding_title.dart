import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Master any topic\nwith clinical precision.",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayLarge,
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideY(begin: .08)
        .scale(begin: const Offset(.98, .98));
  }
}