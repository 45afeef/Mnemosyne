import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/theme/app_buttons.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_theme.dart';
import '../lesson_view_model.dart';
import '../../domain/entities/lesson.dart';
import '../pages/lesson_page.dart';
import '../widgets/assistant_chip_bar.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lessonId,
    required this.viewModel,
  });
  final String lessonId;
  final LessonViewModel viewModel;
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.loadLesson(widget.lessonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<LessonViewModel>(
        builder: (context, viewModel, _) {
          switch (viewModel.state) {
            case LessonLoadState.loading:
            case LessonLoadState.idle:
              return const LessonLoadingView();
            case LessonLoadState.error:
            //afeef
              return LessonErrorView(
                message: viewModel.errorMessage ?? "Something went wrong",
              );
            case LessonLoadState.loaded:
              final Lesson lesson = viewModel.lesson!;
              return LessonPage(
                title: lesson.title,
                progress: lesson.progress,
                blocks: lesson.blocks,
                assistantActions: lesson.assistantActions
                    .map(
                      (item) => AssistantAction(
                        label: item.label,
                        onTap: () {
                          // Connect AI assistant here
                        },
                      ),
                    )
                    .toList(),
                onNext: () {
                  // Navigate to next concept
                },
              );
          }
        },
      ),
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
