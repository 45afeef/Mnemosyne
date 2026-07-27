import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

class PrimaryCTAButton extends StatefulWidget {
  const PrimaryCTAButton({
    super.key,
  });

  @override
  State<PrimaryCTAButton> createState() =>
      _PrimaryCTAButtonState();
}

class _PrimaryCTAButtonState
    extends State<PrimaryCTAButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = true);
      },
      onTapUp: (_) {
        setState(() => pressed = false);
      },
      onTapCancel: () {
        setState(() => pressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.translationValues(
          0,
          pressed ? 4 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(
            AppRadius.xl,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(.18),
              blurRadius: 24,
              offset: Offset(
                0,
                pressed ? 2 : 8,
              ),
            ),
          ],
        ),
        child: SizedBox(
          height: 58,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Start Learning",
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(delay: 250.ms)
        .fadeIn()
        .slideY(begin: .12)
        .scale(begin: const Offset(.96, .96));
  }
}