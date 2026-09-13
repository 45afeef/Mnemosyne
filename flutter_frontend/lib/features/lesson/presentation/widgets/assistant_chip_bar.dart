import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_theme.dart';

class AssistantAction {
  const AssistantAction({required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
}

class AssistantChipBar extends StatelessWidget {
  const AssistantChipBar({super.key, required this.actions});

  final List<AssistantAction> actions;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final action = actions[index];

          return _AssistantChip(action: action)
              .animate(delay: Duration(milliseconds: index * 75))
              .fadeIn(duration: 250.ms)
              .slideX(
                begin: .2,
                end: 0,
                duration: 250.ms,
                curve: Curves.easeOut,
              );
        },
      ),
    );
  }
}

class _AssistantChip extends StatelessWidget {
  const _AssistantChip({required this.action});

  final AssistantAction action;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.full),
        onTap: action.onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action.icon != null) ...[
                Icon(action.icon, size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                action.label,
                style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
