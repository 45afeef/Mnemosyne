import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/theme/app_colors.dart';

class ShimmerProgressBar extends StatelessWidget {
  const ShimmerProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 6,
        child: Stack(
          children: [
            Container(
              color: AppColors.surfaceHighest,
            ),
            Shimmer.fromColors(
              baseColor: AppColors.primary.withOpacity(.15),
              highlightColor: AppColors.primary,
              child: FractionallySizedBox(
                widthFactor: .65,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}