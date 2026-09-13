import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/app/router/routes.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/session_feedback.dart';
import '../providers/lesson_session_provider.dart';
import '../widgets/particle_widget.dart';

class TopicCompletionPage extends ConsumerWidget {
  const TopicCompletionPage({
    super.key,
    required this.feedback,
    this.memoryRetention,
    this.timeSpent,
    this.xpEarned,
    this.nextTopic,
  });

  final SessionFeedback feedback;

  /// Optional because SessionFeedback currently doesn't contain this data.
  final double? memoryRetention;

  /// Optional because SessionFeedback currently doesn't contain this data.
  final Duration? timeSpent;

  /// Optional because SessionFeedback currently doesn't contain this data.
  final int? xpEarned;

  /// Optional because SessionFeedback currently doesn't contain this data.
  final String? nextTopic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.mobileMargin,
                      80,
                      AppSpacing.mobileMargin,
                      AppSpacing.lg,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: AppSpacing.maxContentWidth,
                        ),
                        child: _buildContent(context, ref),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mobileMargin,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grain, color: AppColors.primary, size: 28),
          SizedBox(width: AppSpacing.sm),
          Text(
            'Mnemosyne',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Main content
  // ---------------------------------------------------------------------------

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildSuccessHeader(),

        const SizedBox(height: AppSpacing.lg),

        _buildStatsGrid(context),

        if (feedback.tips.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildTips(),
        ],

        const SizedBox(height: AppSpacing.lg),

        _buildActions(context, ref),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Success header
  // ---------------------------------------------------------------------------

  Widget _buildSuccessHeader() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryContainer.withValues(alpha: 0.20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.30),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 56,
          ),
        ),

        Text(
          feedback.title.isNotEmpty ? feedback.title : 'Topic Mastered',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 32,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            feedback.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 17,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Stats
  // ---------------------------------------------------------------------------

  Widget _buildStatsGrid(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isTablet = width >= 700;

    return Column(
      children: [
        if (isTablet)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildUnderstandingCard()),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildMemoryCard()),
            ],
          )
        else ...[
          _buildUnderstandingCard(),
          const SizedBox(height: AppSpacing.md),
          _buildMemoryCard(),
        ],

        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(child: _buildTimeCard()),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _buildXpCard()),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Understanding
  // ---------------------------------------------------------------------------

  Widget _buildUnderstandingCard() {
    final score = _normalizedScore;
    final percentage = (score * 100).round();

    final String status;

    if (percentage >= 80) {
      status = 'HIGH';
    } else if (percentage >= 60) {
      status = 'GOOD';
    } else {
      status = 'KEEP GOING';
    }

    return _StatContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UNDERSTANDING',
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),

              const SizedBox(width: 8),

              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: _StatusBadge(text: status, color: AppColors.secondary),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _ProgressBar(value: score, color: AppColors.secondary),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Memory
  // ---------------------------------------------------------------------------

  Widget _buildMemoryCard() {
    final score = memoryRetention ?? _normalizedScore;
    final percentage = (score * 100).round();

    final String status;

    if (percentage >= 80) {
      status = 'SOLID';
    } else if (percentage >= 60) {
      status = 'GOOD';
    } else {
      status = 'BUILDING';
    }

    return _StatContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MEMORY RETENTION',
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),

              const SizedBox(width: 8),

              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: _StatusBadge(text: status, color: AppColors.primary),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _ProgressBar(value: score, color: AppColors.primary),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Time
  // ---------------------------------------------------------------------------

  Widget _buildTimeCard() {
    return _StatContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.schedule,
              color: AppColors.onSurfaceVariant,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TIME SPENT',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _formatDuration(timeSpent),
                  style: const TextStyle(
                    color: AppColors.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // XP
  // ---------------------------------------------------------------------------

  Widget _buildXpCard() {
    return _StatContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.tertiary.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bolt, color: AppColors.tertiary, size: 21),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'XP EARNED',
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '+${xpEarned ?? 50} XP',
                  style: const TextStyle(
                    color: AppColors.tertiary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tips
  // ---------------------------------------------------------------------------

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tips for next time',
            style: TextStyle(
              color: AppColors.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        ...feedback.tips.map(
          (tip) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _buildTipCard(tip),
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(FeedbackTip tip) {
    return _StatContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tip.title,
            style: const TextStyle(
              color: AppColors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            tip.description,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: () {
              ref.read(lessonSessionControllerProvider.notifier).reset();

              context.pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onSurface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    nextTopic != null ? 'Next Topic: $nextTopic' : 'Continue',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                const Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        TextButton(
          onPressed: () {
            ref.read(lessonSessionControllerProvider.notifier).reset();

            context.go(Routes.home);
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.onSurfaceVariant,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          child: const Text(
            'Return to Dashboard',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  double get _normalizedScore {
    // If your SessionFeedback.score is already 0.0 - 1.0,
    // this returns it unchanged.
    //
    // If your score is 0 - 100, it converts it to 0.0 - 1.0.

    if (feedback.score > 1) {
      return (feedback.score / 100).clamp(0.0, 1.0);
    }

    return feedback.score.clamp(0.0, 1.0);
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--';
    }

    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return '${minutes}m ${seconds}s';
  }
}

// ============================================================================
// STAT CONTAINER
// ============================================================================

class _StatContainer extends StatelessWidget {
  const _StatContainer({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.30),
        ),
      ),
      child: child,
    );
  }
}

// ============================================================================
// STATUS BADGE
// ============================================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ============================================================================
// PROGRESS BAR
// ============================================================================

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 8,
        child: Stack(
          children: [
            Container(width: double.infinity, color: AppColors.surfaceHighest),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
