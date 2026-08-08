// ============================================================
// PAGE
// ============================================================

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedIndex = 0;

  final TextEditingController _textController = TextEditingController();

  static const int maxCharacters = 200;

  final List<FeedbackOption> options = const [
    FeedbackOption(
      title: 'Everything is working well',
      description: 'I am satisfied with my experience.',
      icon: Icons.thumb_up_outlined,
    ),
    FeedbackOption(
      title: 'Something could be improved',
      description: 'I have some suggestions or feedback.',
      icon: Icons.lightbulb_outline,
    ),
    FeedbackOption(
      title: 'I am having an issue',
      description: 'Something is not working as expected.',
      icon: Icons.warning_amber_outlined,
    ),
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? AppSpacing.desktopMargin
                    : AppSpacing.mobileMargin,
                vertical: AppSpacing.lg,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSpacing.maxContentWidth,
                  ),
                  child: _buildContent(isDesktop),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // APP BAR
  // ==========================================================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: const Text(
        'Feedback',
        style: TextStyle(
          color: AppColors.onBackground,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(width: AppSpacing.sm),
      ],
    );
  }

  // ==========================================================
  // CONTENT
  // ==========================================================

  Widget _buildContent(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),

        const SizedBox(height: AppSpacing.lg),

        _buildSelectionSection(isDesktop),

        const SizedBox(height: AppSpacing.lg),

        _buildTextSection(),

        const SizedBox(height: AppSpacing.lg),

        _buildSubmitButton(isDesktop),
      ],
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tell us what you think',
          style: TextStyle(
            color: AppColors.onBackground,
            fontSize: 32,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Your feedback helps us make the experience better.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // SELECTION SECTION
  // ==========================================================

  Widget _buildSelectionSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How was your experience?',
          style: TextStyle(
            color: AppColors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              options.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == options.length - 1 ? 0 : AppSpacing.md,
                  ),
                  child: _buildOptionCard(index, options[index]),
                ),
              ),
            ),
          )
        else
          Column(
            children: List.generate(
              options.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _buildOptionCard(index, options[index]),
              ),
            ),
          ),
      ],
    );
  }

  // ==========================================================
  // OPTION CARD
  // ==========================================================

  Widget _buildOptionCard(int index, FeedbackOption option) {
    final bool isSelected = selectedIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryContainer.withValues(alpha: 0.10)
                : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRadioIndicator(isSelected),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      option.icon,
                      size: 24,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      option.title,
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Text(
                      option.description,
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // RADIO INDICATOR
  // ==========================================================

  Widget _buildRadioIndicator(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.outlineVariant,
          width: 2,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: isSelected ? 10 : 0,
          height: isSelected ? 10 : 0,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // TEXTAREA
  // ==========================================================

  Widget _buildTextSection() {
    final int length = _textController.text.length;
    final bool exceedsLimit = length > maxCharacters;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tell us more',
          style: TextStyle(
            color: AppColors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Stack(
          children: [
            TextField(
              controller: _textController,
              minLines: 6,
              maxLines: 10,
              maxLength: null,
              onChanged: (_) {
                setState(() {});
              },
              style: const TextStyle(
                color: AppColors.onSurface,
                fontSize: 15,
                height: 1.5,
              ),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'Write your feedback here...',
                hintStyle: const TextStyle(color: AppColors.onSurfaceVariant),
                filled: true,
                fillColor: AppColors.surfaceContainer,
                contentPadding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  40,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            Positioned(
              right: AppSpacing.md,
              bottom: AppSpacing.sm,
              child: Text(
                '$length / $maxCharacters',
                style: TextStyle(
                  color: exceedsLimit
                      ? AppColors.error
                      : AppColors.onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // SUBMIT BUTTON
  // ==========================================================

  Widget _buildSubmitButton(bool isDesktop) {
    return SizedBox(
      width: isDesktop ? 220 : double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: () {
          _submit();
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: const Text('Submit feedback'),
      ),
    );
  }

  // ==========================================================
  // SUBMIT
  // ==========================================================

  void _submit() {
    final feedback = _textController.text.trim();

    if (feedback.length > maxCharacters) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please keep your feedback under 200 characters.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks for your feedback!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

// ============================================================
// MODEL
// ============================================================

class FeedbackOption {
  final String title;
  final String description;
  final IconData icon;

  const FeedbackOption({
    required this.title,
    required this.description,
    required this.icon,
  });
}
