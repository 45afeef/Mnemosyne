import 'package:flutter/material.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/entities/learning_item.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/module.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ReviewSyllabusPage extends StatefulWidget {
  const ReviewSyllabusPage({super.key});

  @override
  State<ReviewSyllabusPage> createState() => _ReviewSyllabusPageState();
}

class _ReviewSyllabusPageState extends State<ReviewSyllabusPage> {
  late List<Module> modules;

  @override
  void initState() {
    super.initState();

    final emptyLearningItem = LearningItem(
      id: "id",
      title: "title",
      description: "description",
      order: 0,
    );

    modules = [
      Module(
        id: '',
        order: 1,
        name: "Module 1: Fundamentals",
        learningItems: [
          emptyLearningItem.copyWith(
            title: "Foundations of Neural Networks",
            order: 1,
          ),
          emptyLearningItem.copyWith(
            title: "Activation Functions Deep-Dive",
            order: 2,
          ),
        ],
      ),
      Module(
        id: '',
        order: 1,
        name: "Module 2: Advanced Architectures",
        learningItems: [
          emptyLearningItem.copyWith(
            title: "Backpropagation & Chain Rule",
            order: 1,
          ),
          emptyLearningItem.copyWith(
            title: "CNNs vs RNNs Comparison",
            order: 2,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.mobileMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImportSection(),

                    const SizedBox(height: AppSpacing.lg),

                    ...modules.map(_buildModule),

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
                        onPressed: _addModule,
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

  Widget _buildAppBar() {
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

  Widget _buildModule(Module module) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _editModule(module),
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
                  setState(() {
                    modules.remove(module);
                  });
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
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex--;
                }

                final item = module.learningItems.removeAt(oldIndex);

                module.learningItems.insert(newIndex, item);
              });
            },
            itemBuilder: (context, index) {
              final topic = module.learningItems[index];

              return _buildTopicCard(
                key: ValueKey(topic),
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
              onTap: () => _addTopic(module),
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
              onPressed: () => _editTopic(topic),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: AppColors.outline,
              onPressed: () {
                setState(() {
                  module.learningItems.remove(topic);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editTopic(LearningItem topic) async {
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
      setState(() {
        topic = topic.copyWith(title: result);
      });
    }
  }

  Future<void> _editModule(Module module) async {
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
      setState(() {
        module = module.copyWith(name: result);
      });
    }
  }

  void _addTopic(Module module) {
    setState(() {
      module.learningItems.add(
        LearningItem(title: "New Topic", id: '', description: '', order: 99),
      );
    });

    _editTopic(module.learningItems.last);
  }

  void _addModule() {
    setState(() {
      modules.add(
        Module(name: "New Module", learningItems: [], id: '', order: 99),
      );
    });

    _editModule(modules.last);
  }
}
