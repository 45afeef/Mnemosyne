import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';

class AiLoader extends StatelessWidget {
  const AiLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(.18),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(.9, .9),
                end: const Offset(1.08, 1.08),
                duration: 1500.ms,
                curve: Curves.easeInOut,
              ),

          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withOpacity(.25),
              ),
            ),
            child: const Icon(
              Icons.psychology,
              color: AppColors.primary,
              size: 34,
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(.96, .96),
                end: const Offset(1.05, 1.05),
                duration: 1400.ms,
              )
              .then()
              .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(.96, .96),
                duration: 1400.ms,
              ),
        ],
      ),
    );
  }
}