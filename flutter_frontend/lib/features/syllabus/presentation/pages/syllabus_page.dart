import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/module.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/learning_item.dart';
import '../provider/syllabus_provider.dart';
import '../notifier/syllabus_notifier.dart';

class ReviewSyllabusPage extends ConsumerWidget {
  const ReviewSyllabusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syllabus = ref.watch(syllabusNotifierProvider).syllabus;
    final syllabusNotifier = ref.read(syllabusNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.mobileMargin),
          child: SizedBox(
            height: 56,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.rocket_launch),
              label: const Text("START LEARNING"),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.mobileMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImportSection(),

                    const SizedBox(height: AppSpacing.lg),
                    if (syllabus == null)
                      Center(child: Text("No Syllabus"))
                    else
                      ...syllabus.subjects.map(
                        (subject) =>
                            _buildSubject(context, syllabusNotifier, subject),
                      ),

                    const SizedBox(height: AppSpacing.lg),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.surfaceHigh,
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                          ),
                        ),
                        onPressed: () {
                          // _addModule(syllabusNotifier, subject
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text("Create New Module"),
                      ),
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mobileMargin,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceHighest)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            color: AppColors.primary,
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Review Syllabus",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            color: AppColors.primary,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildImportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "IMPORT SOURCE",
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: const TextField(
                  style: TextStyle(color: AppColors.onSurface),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.link, color: AppColors.outline),
                    hintText: "Paste article or YouTube URL...",
                    hintStyle: TextStyle(color: AppColors.outline),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surfaceHigh,
                foregroundColor: AppColors.primary,
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubject(
    BuildContext context,
    SyllabusNotifier notifier,
    Subject subject,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          ...subject.modules.map(
            (module) => _buildModule(context, notifier, subject, module),
          ),

          const SizedBox(height: AppSpacing.md),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _addModule(notifier, subject),
              icon: const Icon(Icons.library_add),
              label: const Text("Create New Module"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModule(
    BuildContext context,
    SyllabusNotifier notifier,
    Subject subject,
    Module module,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _editModule(context, notifier, subject, module),
                  child: Text(
                    module.name,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  notifier.removeModule(
                    subjectId: subject.id,
                    moduleId: module.id,
                  );
                },
                icon: const Icon(Icons.delete_outline),
                color: AppColors.outline,
              ),
            ],
          ),

          const SizedBox(height: 12),

          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: module.learningItems.length,
            onReorderItem: (oldIndex, newIndex) {
              notifier.reorderTopics(
                subjectId: subject.id,
                moduleId: module.id,
                oldIndex: oldIndex,
                newIndex: newIndex,
              );
            },

            itemBuilder: (context, index) {
              final topic = module.learningItems[index];

              return _buildTopicCard(
                key: ValueKey(topic.id),
                context: context,
                syllabusNotifier: notifier,
                subject: subject,
                module: module,
                topic: topic,
                index: index,
              );
            },
          ),

          const SizedBox(height: 12),

          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: AppColors.outlineVariant,
              dashPattern: const [8, 4],
              // borderType: BorderType.RRect,
              radius: const Radius.circular(AppRadius.lg),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () => _addTopic(notifier, subject, module),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: AppColors.onSurfaceVariant,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Add Topic",
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard({
    required Key key,
    required BuildContext context,
    required SyllabusNotifier syllabusNotifier,
    required Subject subject,
    required Module module,
    required LearningItem topic,
    required int index,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_indicator, color: AppColors.outline),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(color: AppColors.onSurface, fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: AppColors.primary,
              onPressed: () =>
                  _editTopic(context, syllabusNotifier, subject, module, topic),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: AppColors.outline,
              onPressed: () {
                syllabusNotifier.removeTopic(
                  subjectId: subject.id,
                  moduleId: module.id,
                  topicId: topic.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editTopic(
    BuildContext context,
    SyllabusNotifier notifier,
    Subject subject,
    Module module,
    LearningItem topic,
  ) async {
    final controller = TextEditingController(text: topic.title);

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          title: const Text(
            "Rename Topic",
            style: TextStyle(color: AppColors.onSurface),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: AppColors.onSurface),
            decoration: const InputDecoration(hintText: "Topic name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      notifier.renameTopic(
        subjectId: subject.id,
        moduleId: module.id,
        topicId: topic.id,
        title: result,
      );
    }
  }

  Future<void> _editModule(
    BuildContext context,
    SyllabusNotifier notifier,

    Subject subject,
    Module module,
  ) async {
    final controller = TextEditingController(text: module.name);

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          title: const Text(
            "Rename Module",
            style: TextStyle(color: AppColors.onSurface),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: AppColors.onSurface),
            decoration: const InputDecoration(hintText: "Module name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      notifier.renameModule(
        subjectId: subject.id,
        moduleId: module.id,
        name: result,
      );
    }
  }

  void _addTopic(SyllabusNotifier notifier, Subject subject, Module module) {
    notifier.addTopic(subjectId: subject.id, moduleId: module.id);
  }

  void _addModule(SyllabusNotifier notifier, Subject subject) {
    notifier.addModule(subjectId: subject.id);
  }
}
