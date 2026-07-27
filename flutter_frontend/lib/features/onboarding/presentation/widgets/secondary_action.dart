import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';

class SecondaryAction extends StatelessWidget {
  const SecondaryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Already a member? ",
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant),
        children: [
          TextSpan(
            text: "Sign in",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate(delay: 350.ms).fadeIn().slideY(begin: .08);
  }
}
