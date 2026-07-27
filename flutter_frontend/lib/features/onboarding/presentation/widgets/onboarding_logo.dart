import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.ambient,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
        )
        .animate()
        .fadeIn(duration: 700.ms)
        .scale(begin: const Offset(.9, .9), curve: Curves.easeOutExpo)
        .slideY(begin: -.2, curve: Curves.easeOutExpo);
  }
}
