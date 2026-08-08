import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../lesson_session/domain/entities/session_step.dart'
    show FlashcardStep;
import '../../../../lesson_session/presentation/providers/lesson_session_provider.dart';
import '../../providers/flashcard_provider.dart';

class FlashcardView extends ConsumerWidget {
  const FlashcardView({super.key, required this.step});

  final FlashcardStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flashcardControllerProvider);
    final controller = ref.read(flashcardControllerProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            _Flashcard(
              text: state.isFlipped
                  ? step.flashcard.back
                  : step.flashcard.front,
              isFlipped: state.isFlipped,
              onTap: controller.flip,
            ),

            const SizedBox(height: AppSpacing.lg),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: SizedBox(
                height: 80,
                child: state.isFlipped
                    ? _FlashcardActions(
                        key: const ValueKey('actions'),
                        onMastered: () {
                          controller.markMastered();

                          ref
                              .read(lessonSessionControllerProvider.notifier)
                              .completeStep(controller.result(step.id));
                        },
                        onReview: () {
                          controller.markNeedsReview();

                          ref
                              .read(lessonSessionControllerProvider.notifier)
                              .completeStep(controller.result(step.id));
                        },
                      )
                    : const _FlipHint(key: ValueKey('hint')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// FLASHCARD
// ============================================================================

class _Flashcard extends StatelessWidget {
  const _Flashcard({
    required this.text,
    required this.isFlipped,
    required this.onTap,
  });

  final String text;
  final bool isFlipped;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isFlipped
          ? 'Flashcard answer. Tap to flip back.'
          : 'Flashcard question. Tap to reveal answer.',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
                child: child,
              ),
            );
          },
          child: _FlashcardSurface(
            key: ValueKey(isFlipped),
            text: text,
            isFlipped: isFlipped,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FLASHCARD SURFACE
// ============================================================================

class _FlashcardSurface extends StatelessWidget {
  const _FlashcardSurface({
    super.key,
    required this.text,
    required this.isFlipped,
  });

  final String text;
  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 320, maxWidth: 680),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFlipped
              ? AppColors.secondary.withValues(alpha: 0.45)
              : AppColors.outlineVariant,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle accent glow.
          Positioned(
            top: -70,
            right: -70,
            child: IgnorePointer(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isFlipped ? AppColors.secondary : AppColors.primary)
                      .withValues(alpha: 0.06),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CardLabel(isFlipped: isFlipped),

                const SizedBox(height: 48),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 22,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                _FlipIndicator(isFlipped: isFlipped),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CARD LABEL
// ============================================================================

class _CardLabel extends StatelessWidget {
  const _CardLabel({required this.isFlipped});

  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    final color = isFlipped ? AppColors.secondary : AppColors.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isFlipped ? Icons.lightbulb_outline : Icons.style_outlined,
          size: 17,
          color: color,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          isFlipped ? 'ANSWER' : 'FLASHCARD',
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// FLIP INDICATOR
// ============================================================================

class _FlipIndicator extends StatelessWidget {
  const _FlipIndicator({required this.isFlipped});

  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.touch_app_outlined,
          size: 16,
          color: AppColors.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          isFlipped ? 'Tap to see front' : 'Tap to reveal answer',
          style: const TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// FLIP HINT
// ============================================================================

class _FlipHint extends StatelessWidget {
  const _FlipHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Tap the card when you’re ready to reveal the answer.',
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 13),
    );
  }
}

// ============================================================================
// ACTIONS
// ============================================================================

class _FlashcardActions extends StatelessWidget {
  const _FlashcardActions({
    super.key,
    required this.onMastered,
    required this.onReview,
  });

  final VoidCallback onMastered;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        SizedBox(
          height: 50,
          child: FilledButton.icon(
            onPressed: onMastered,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onSurface,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.check, size: 19),
            label: const Text(
              'I know this',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),

        SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            onPressed: onReview,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.onSurface,
              side: const BorderSide(color: AppColors.outlineVariant),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text(
              'Review again',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
