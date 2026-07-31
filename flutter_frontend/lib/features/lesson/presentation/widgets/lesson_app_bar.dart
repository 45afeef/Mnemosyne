import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_theme.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onMore,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,

      leading: IconButton(
        onPressed: onBack ?? () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
      ),

      title: Text(
        title,
        style: AppTextTheme.textTheme.headlineMedium?.copyWith(
          color: AppColors.primary,
        ),
      ),

      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          onPressed: onMore,
          icon: const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
