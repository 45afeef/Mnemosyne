import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

/// ---------------------------------------------------------------------------
/// UPCOMING CARD
/// ---------------------------------------------------------------------------
class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            "UPCOMING",
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Column(
            children: const [
              UpcomingTile(title: "Activation Functions", divider: true),
              UpcomingTile(title: "Backpropagation"),
            ],
          ),
        ),
      ],
    );
  }
}

class UpcomingTile extends StatelessWidget {
  final String title;
  final bool divider;

  const UpcomingTile({super.key, required this.title, this.divider = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              const Icon(
                Icons.radio_button_unchecked,
                size: 18,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (divider) const Divider(height: 1, color: AppColors.outlineVariant),
      ],
    );
  }
}
