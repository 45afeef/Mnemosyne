import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  final double progress;

  const ProgressRing({super.key, this.progress = .75});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,

      child: Stack(
        alignment: Alignment.center,

        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            color: AppColors.primaryContainer,
            backgroundColor: AppColors.outlineVariant,
          ),

          Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text("22", style: Theme.of(context).textTheme.headlineMedium),

              Text("/30 min"),
            ],
          ),
        ],
      ),
    );
  }
}
