import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

class LessonProgress extends StatelessWidget {
  const LessonProgress({super.key, required this.value});

  /// Value between 0.0 and 1.0
  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value.clamp(0, 1)),
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
        builder: (context, animatedValue, _) {
          return LinearProgressIndicator(
            value: animatedValue,
            minHeight: 8,
            backgroundColor: AppColors.surfaceContainer,
            valueColor: const AlwaysStoppedAnimation(
              AppColors.primaryContainer,
            ),
          );
        },
      ),
    );
  }
}
