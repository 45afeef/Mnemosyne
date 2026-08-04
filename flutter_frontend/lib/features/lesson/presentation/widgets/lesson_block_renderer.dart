import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_theme.dart';
import '../models/lesson_block.dart';

class LessonBlockRenderer extends StatelessWidget {
  const LessonBlockRenderer({super.key, required this.block});

  final LessonBlock block;

  @override
  Widget build(BuildContext context) {
    return switch (block) {
      HeadingBlock() => _Heading(block: block as HeadingBlock),
      ParagraphBlock() => _Paragraph(block: block as ParagraphBlock),
      QuoteBlock() => _Quote(block: block as QuoteBlock),
      ListBlock() => _List(block: block as ListBlock),
      ImageBlock() => _Image(block: block as ImageBlock),
      CodeBlock() => _Code(block: block as CodeBlock),
      DividerBlock() => const _Divider(),
      CalloutBlock() => _Callout(block: block as CalloutBlock),
    };
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.block});

  final HeadingBlock block;

  @override
  Widget build(BuildContext context) {
    final style = switch (block.level) {
      1 => AppTextTheme.textTheme.headlineMedium!,
      2 => AppTextTheme.textTheme.headlineMedium!.copyWith(fontSize: 24),
      3 => AppTextTheme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w700,
      ),
      _ => AppTextTheme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w600,
      ),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(block.text, style: style.copyWith(color: AppColors.primary)),
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph({required this.block});

  final ParagraphBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: MarkdownBody(
        selectable: true,
        data: block.markdown,
        styleSheet: MarkdownStyleSheet(
          p: AppTextTheme.textTheme.bodyLarge!.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          strong: AppTextTheme.textTheme.bodyLarge!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
          em: AppTextTheme.textTheme.bodyLarge!.copyWith(
            color: AppColors.secondary,
            fontStyle: FontStyle.italic,
          ),
          a: AppTextTheme.textTheme.bodyLarge!.copyWith(
            color: AppColors.secondary,
            decoration: TextDecoration.underline,
          ),
          code: const TextStyle(fontFamily: 'monospace'),
        ),
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  const _Quote({required this.block});

  final QuoteBlock block;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
      ),
      child: MarkdownBody(
        selectable: true,
        data: block.markdown,
        styleSheet: MarkdownStyleSheet(
          p: AppTextTheme.textTheme.bodyMedium!.copyWith(
            color: AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.block});

  final ListBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        children: List.generate(block.items.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.ordered ? '${index + 1}.' : '•',
                  style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: MarkdownBody(
                    data: block.items[index],
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      p: AppTextTheme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.block});

  final ImageBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Column(
          children: [
            Image.network(
              block.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            if (block.caption != null)
              Container(
                width: double.infinity,
                color: AppColors.surfaceContainer,
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  block.caption!,
                  style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Code extends StatelessWidget {
  const _Code({required this.block});

  final CodeBlock block;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: SelectableText(
        block.code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: AppColors.onSurface,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(color: AppColors.outlineVariant),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.block});

  final CalloutBlock block;

  Color get color {
    switch (block.type) {
      case CalloutType.info:
        return AppColors.primary;
      case CalloutType.success:
        return AppColors.success;
      case CalloutType.warning:
        return AppColors.warning;
      case CalloutType.error:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color),
      ),
      child: MarkdownBody(
        selectable: true,
        data: block.markdown,
        styleSheet: MarkdownStyleSheet(
          p: AppTextTheme.textTheme.bodyMedium!.copyWith(
            color: AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}
