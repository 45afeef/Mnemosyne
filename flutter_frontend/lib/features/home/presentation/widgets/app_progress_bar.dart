import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: 6,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Track
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHigh,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const SizedBox.expand(),
                    ),

                    // Progress
                    FractionallySizedBox(
                      widthFactor: value,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: const LinearGradient(
                            colors: [AppColors.tertiary, AppColors.secondary],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary,
                              blurRadius: 8,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
