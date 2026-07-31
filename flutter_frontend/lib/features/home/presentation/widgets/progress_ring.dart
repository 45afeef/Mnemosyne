import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  final double progress;

  const ProgressRing({super.key, this.progress = .75});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CircularProgressIndicator(
            value: progress,
            color: AppColors.primaryContainer,
            backgroundColor: AppColors.outlineVariant,
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "22",
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text("/30 min", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
