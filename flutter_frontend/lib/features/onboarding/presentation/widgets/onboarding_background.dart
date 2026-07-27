import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: AppColors.background,
        ),

        const _AmbientGlow(
          alignment: Alignment(-1.2, -1.2),
          color: Color(0x338083FF),
          size: 320,
        ),

        const _AmbientGlow(
          alignment: Alignment(1.3, 1.2),
          color: Color(0x224EDEA3),
          size: 360,
        ),

        const _AmbientGlow(
          alignment: Alignment(0.0, -1.5),
          color: Color(0x11C0C1FF),
          size: 280,
        ),
      ],
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double size;

  const _AmbientGlow({
    required this.alignment,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 90,
            sigmaY: 90,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}