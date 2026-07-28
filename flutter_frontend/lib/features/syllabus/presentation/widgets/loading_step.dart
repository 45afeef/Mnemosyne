import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_colors.dart';

class LoadingStep extends StatelessWidget {
  const LoadingStep({
    super.key,
    required this.title,
    required this.visible,
  });

  final String title;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visible ? 1 : .25,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: visible
                  ? Container(
                      key: const ValueKey("done"),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.success.withOpacity(.15),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.success,
                        size: 18,
                      ),
                    ).animate().scale(
                        begin: const Offset(.3, .3),
                        curve: Curves.elasticOut,
                      )
                  : Container(
                      key: const ValueKey("pending"),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.outlineVariant,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}