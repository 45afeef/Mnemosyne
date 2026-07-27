import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';

class FooterTags extends StatelessWidget {
  const FooterTags({super.key});

  Widget dot() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: AppColors.onSurfaceVariant,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        letterSpacing: 2,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label("Intuition"),
          const SizedBox(width: 10),
          dot(),
          const SizedBox(width: 10),
          label("Retention"),
          const SizedBox(width: 10),
          dot(),
          const SizedBox(width: 10),
          label("Mastery"),
        ],
      ),
    ).animate(delay: 450.ms).fadeIn().slideY(begin: .1);
  }
}
