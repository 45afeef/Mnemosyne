import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnemosyne_learn/features/lesson/presentation/lesson_markdown_parser.dart';
import 'package:mnemosyne_learn/features/lesson/presentation/models/lesson_block.dart';
import '../../../../app/theme/app_buttons.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_theme.dart';
import '../../../lesson_session/domain/entities/session_step.dart';
import '../../../lesson_session/domain/entities/step_result.dart';
import '../../../lesson_session/presentation/providers/lesson_session_provider.dart';
import '../pages/lesson_page.dart';
import '../widgets/assistant_chip_bar.dart';

class LessonScreen extends ConsumerWidget {
  const LessonScreen({super.key, required this.step});

  final LearningStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late List<LessonBlock> blocks = LessonMarkdownParser.parse(
      step.content.markdown,
    );

    return LessonPage(
      title: step.title,
      progress: 0.4,
      blocks: blocks,
      assistantActions: step.content.title
          .split("")
          .toList()
          .map(
            (item) => AssistantAction(
              label: item, //.label,
              onTap: () {
                // Connect AI assistant here
              },
            ),
          )
          .toList(),
      onNext: () {
        ref
            .read(lessonSessionControllerProvider.notifier)
            .completeStep(LearningStepCompleted(stepId: step.id));
      },
    );
  }
}

class LessonLoadingView extends StatelessWidget {
  const LessonLoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }
}

class LessonErrorView extends StatelessWidget {
  const LessonErrorView({super.key, required this.message, this.onRetry});
  final String message;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.mobileMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                "Unable to load lesson",
                textAlign: TextAlign.center,
                style: AppTextTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryCTAButton(
                text: "Try Again",
                onPressed:
                    onRetry ??
                    () {
                      Navigator.pop(context);
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
