import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

/// ---------------------------------------------------------------------------
/// CURRENT TOPIC CARD
/// ---------------------------------------------------------------------------
class CurrentTopicCard extends StatelessWidget {
  const CurrentTopicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        context.push(Routes.syllabusCompact);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary.withOpacity(.35),
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: AppColors.secondary,
                  ),
                ),
                const Spacer(),
                const Text(
                  "75% Complete",
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Neural Networks Fundamentals",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Module 1 • Step 3 of 8 • Multilayer Perceptrons",
              style: TextStyle(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 28),
            Row(
              children: const [
                Text(
                  "Continue Learning",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 18, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
