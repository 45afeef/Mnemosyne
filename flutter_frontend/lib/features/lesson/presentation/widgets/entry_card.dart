import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

class LearningEntryCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Color container;
  final VoidCallback onTap;

  const LearningEntryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.container,
    required this.onTap,
  });

  @override
  State<LearningEntryCard> createState() => _LearningEntryCardState();
}

class _LearningEntryCardState extends State<LearningEntryCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: pressed ? .98 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: pressed
              ? AppColors.surfaceBright
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: widget.accent.withOpacity(.35),
            width: 2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => pressed = true),
          onTapCancel: () => setState(() => pressed = false),
          onTapUp: (_) => setState(() => pressed = false),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.container,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: 34,
                    color: AppColors.background,
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right,
                  color: widget.accent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}