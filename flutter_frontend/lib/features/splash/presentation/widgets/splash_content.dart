import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.mobileMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SplashLogo(),

          SizedBox(height: AppSpacing.md),

          SplashTitle(),

          SizedBox(height: AppSpacing.sm),

          SplashSubtitle(),

          SizedBox(height: AppSpacing.md),

          SplashLoadingBar(),
        ],
      ),
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.ambient,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset("assets/images/logo wordmark.png", fit: BoxFit.cover),
    );
  }
}

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Mnemosyne",
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.displayLarge?.copyWith(color: AppColors.primary),
    );
  }
}

class SplashSubtitle extends StatefulWidget {
  const SplashSubtitle({super.key});

  @override
  State<SplashSubtitle> createState() => _SplashSubtitleState();
}

class _SplashSubtitleState extends State<SplashSubtitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: .55, end: .95).animate(controller),
      child: Text(
        "Preparing your learning workspace...",
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
      ),
    );
  }
}

class SplashLoadingBar extends StatefulWidget {
  const SplashLoadingBar({super.key});

  @override
  State<SplashLoadingBar> createState() => _SplashLoadingBarState();
}

class _SplashLoadingBarState extends State<SplashLoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Container(
          color: AppColors.primary.withOpacity(.08),
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, __) {
              return Align(
                alignment: Alignment(controller.value * 2 - 1, 0),
                child: FractionallySizedBox(
                  widthFactor: .2 + (.3 * controller.value),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.primary),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
