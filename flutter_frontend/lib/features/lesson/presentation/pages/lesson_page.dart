// lib/features/lesson/pages/lesson_page.dart

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../models/lesson_block.dart';
import '../widgets/assistant_chip_bar.dart';
import '../widgets/lesson_bottom_action.dart';
import '../widgets/lesson_content.dart';
import '../controller/lesson_reveal_controller.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({
    super.key,
    required this.title,
    required this.blocks,
    this.assistantActions = const [],
    required this.onNext,
  });

  final String title;
  final List<LessonBlock> blocks;
  final List<AssistantAction> assistantActions;
  final VoidCallback onNext;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late final LessonRevealController controller;

  @override
  void initState() {
    super.initState();

    controller = LessonRevealController(totalBlocks: widget.blocks.length);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _next() {
    if (controller.hasMore) {
      controller.revealNext();
      return;
    }

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.mobileMargin,
                ),

                child: LessonContent(
                  blocks: widget.blocks,
                  controller: controller,
                ),
              ),
            ),

            AnimatedBuilder(
              animation: controller,

              builder: (_, __) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.mobileMargin),

                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),

                        child: controller.isCompleted
                            ? AssistantChipBar(actions: widget.assistantActions)
                            : const SizedBox(),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      LessonBottomAction(
                        hasMore: controller.hasMore,

                        onPressed: _next,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
