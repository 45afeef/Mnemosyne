import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../lesson_session/domain/entities/session_step.dart'
    show McqStep;
import '../../../../lesson_session/presentation/providers/lesson_session_provider.dart';
import '../../providers/mcq_provider.dart';

class McqView extends ConsumerWidget {
  const McqView({super.key, required this.step});

  final McqStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mcqControllerProvider(step.mcq));
    final controller = ref.read(mcqControllerProvider(step.mcq).notifier);

    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          _QuestionHeader(question: step.mcq.question),

          const SizedBox(height: AppSpacing.lg),

          // Options
          ...step.mcq.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;

            final isSelected = state.selectedOptionId == option.id;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == step.mcq.options.length - 1
                    ? 0
                    : AppSpacing.sm,
              ),
              child: _McqOption(
                label: _optionLabel(index),
                text: option.text,
                selected: isSelected,
                enabled: !state.isSubmitted,
                submitted: state.isSubmitted,
                isCorrect:
                    state.isSubmitted && isSelected && state.isCorrect == true,
                isIncorrect:
                    state.isSubmitted && isSelected && state.isCorrect == false,
                onTap: () {
                  controller.selectOption(option.id);
                },
              ),
            );
          }),

          const SizedBox(height: AppSpacing.lg),
          Spacer(),

          // Result / action area
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: state.isSubmitted
                ? _SubmittedState(
                    key: const ValueKey('submitted'),
                    isCorrect: state.isCorrect == true,
                    onContinue: () {
                      ref
                          .read(lessonSessionControllerProvider.notifier)
                          .completeStep(controller.result);
                    },
                  )
                : _SubmitState(
                    key: const ValueKey('submit'),
                    enabled: state.selectedOptionId != null,
                    onSubmit: controller.submit,
                  ),
          ),
        ],
      ),
    );
  }

  String _optionLabel(int index) {
    return String.fromCharCode('A'.codeUnitAt(0) + index);
  }
}

// ============================================================================
// QUESTION
// ============================================================================

class _QuestionHeader extends StatelessWidget {
  const _QuestionHeader({required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.20),
                ),
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: AppColors.primary,
                size: 19,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text(
              'QUESTION',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        Text(
          question,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 24,
            height: 1.3,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        const Text(
          'Choose the best answer.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// OPTION
// ============================================================================

class _McqOption extends StatelessWidget {
  const _McqOption({
    required this.label,
    required this.text,
    required this.selected,
    required this.enabled,
    required this.submitted,
    required this.isCorrect,
    required this.isIncorrect,
    required this.onTap,
  });

  final String label;
  final String text;
  final bool selected;
  final bool enabled;
  final bool submitted;
  final bool isCorrect;
  final bool isIncorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    final Color backgroundColor;
    final Color labelBackground;
    final Color labelColor;

    if (isCorrect) {
      borderColor = AppColors.secondary;
      backgroundColor = AppColors.secondary.withValues(alpha: 0.10);
      labelBackground = AppColors.secondary.withValues(alpha: 0.18);
      labelColor = AppColors.secondary;
    } else if (isIncorrect) {
      borderColor = AppColors.error;
      backgroundColor = AppColors.error.withValues(alpha: 0.08);
      labelBackground = AppColors.error.withValues(alpha: 0.15);
      labelColor = AppColors.error;
    } else if (selected) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primaryContainer.withValues(alpha: 0.10);
      labelBackground = AppColors.primary.withValues(alpha: 0.16);
      labelColor = AppColors.primary;
    } else {
      borderColor = AppColors.outlineVariant;
      backgroundColor = AppColors.surfaceContainer;
      labelBackground = AppColors.surfaceHigh;
      labelColor = AppColors.onSurfaceVariant;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        splashColor: AppColors.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.primary.withValues(alpha: 0.04),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: selected || isCorrect || isIncorrect ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              _OptionIndicator(
                label: label,
                selected: selected,
                submitted: submitted,
                isCorrect: isCorrect,
                isIncorrect: isIncorrect,
                backgroundColor: labelBackground,
                foregroundColor: labelColor,
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              _TrailingIndicator(
                selected: selected,
                submitted: submitted,
                isCorrect: isCorrect,
                isIncorrect: isIncorrect,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// OPTION INDICATOR
// ============================================================================

class _OptionIndicator extends StatelessWidget {
  const _OptionIndicator({
    required this.label,
    required this.selected,
    required this.submitted,
    required this.isCorrect,
    required this.isIncorrect,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final bool selected;
  final bool submitted;
  final bool isCorrect;
  final bool isIncorrect;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    if (isCorrect || isIncorrect) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isCorrect ? Icons.check : Icons.close,
          color: foregroundColor,
          size: 20,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TRAILING INDICATOR
// ============================================================================

class _TrailingIndicator extends StatelessWidget {
  const _TrailingIndicator({
    required this.selected,
    required this.submitted,
    required this.isCorrect,
    required this.isIncorrect,
  });

  final bool selected;
  final bool submitted;
  final bool isCorrect;
  final bool isIncorrect;

  @override
  Widget build(BuildContext context) {
    if (isCorrect) {
      return const Icon(
        Icons.check_circle,
        color: AppColors.secondary,
        size: 22,
      );
    }

    if (isIncorrect) {
      return const Icon(Icons.cancel, color: AppColors.error, size: 22);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.outlineVariant,
          width: 2,
        ),
      ),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: selected ? 1 : 0,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SUBMIT STATE
// ============================================================================

class _SubmitState extends StatelessWidget {
  const _SubmitState({
    super.key,
    required this.enabled,
    required this.onSubmit,
  });

  final bool enabled;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 54,
          child: FilledButton(
            onPressed: enabled ? onSubmit : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              disabledBackgroundColor: AppColors.surfaceHigh,
              foregroundColor: AppColors.onSurface,
              disabledForegroundColor: AppColors.onSurfaceVariant,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Check answer',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        const Text(
          'Select an answer to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12),
        ),
      ],
    );
  }
}

// ============================================================================
// SUBMITTED STATE
// ============================================================================

class _SubmittedState extends StatelessWidget {
  const _SubmittedState({
    super.key,
    required this.isCorrect,
    required this.onContinue,
  });

  final bool isCorrect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.secondary : AppColors.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCorrect ? Icons.check : Icons.info_outline,
                  color: color,
                  size: 21,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect ? 'Correct!' : 'Not quite.',
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isCorrect
                          ? 'You got this one right.'
                          : 'Review the concept and keep going.',
                      style: const TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 54,
          child: FilledButton(
            onPressed: onContinue,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onSurface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: AppSpacing.sm),
                Icon(Icons.arrow_forward, size: 19),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
