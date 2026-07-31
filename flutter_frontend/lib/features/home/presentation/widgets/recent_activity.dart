import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// ---------------------------------------------------------------------------
/// RECENT ACTIVITY
/// ---------------------------------------------------------------------------
class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "RECENT ACTIVITY",
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const ActivityTimelineTile(
          title: "Completed Foundations of Neural Networks",
          subtitle: "2h ago • 45 XP earned",
          color: AppColors.secondary,
          showLine: true,
        ),
        const ActivityTimelineTile(
          title: "Session started",
          subtitle: "2h 15m ago",
          color: AppColors.primary,
          showLine: false,
        ),
      ],
    );
  }
}

class ActivityTimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final bool showLine;

  const ActivityTimelineTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (showLine)
                  Container(
                    width: 2,
                    height: 48,
                    margin: const EdgeInsets.only(top: 4),
                    color: AppColors.outlineVariant,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
