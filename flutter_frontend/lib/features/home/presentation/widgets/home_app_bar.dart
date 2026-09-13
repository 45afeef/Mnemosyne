import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/router/routes.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.background,

      titleSpacing: AppSpacing.mobileMargin,

      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
          ),

          const SizedBox(width: 12),

          Text(
            "Mnemosyne",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

        IconButton(
          onPressed: () => context.push(Routes.goalList),
          icon: const Icon(Icons.flag, color: AppColors.primary),
          tooltip: 'Change goal',
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle, color: AppColors.primary),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
