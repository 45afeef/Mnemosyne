import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/syllabus.dart';
import '../provider/syllabus_provider.dart';
import '../state/syllabus_state.dart';

class CompactSyllabusPage extends ConsumerStatefulWidget {
  const CompactSyllabusPage({super.key});

  @override
  ConsumerState<CompactSyllabusPage> createState() =>
      _CompactSyllabusPageState();
}

class _CompactSyllabusPageState extends ConsumerState<CompactSyllabusPage> {
  final Set<String> _completed = {};
  String? _uncompletedSessionTopic;
  final Map<String, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final db = await ref.read(databaseHelperProvider).database;

    final completedRows = await db.query(
      'lesson_sessions',
      where: 'is_completed = ?',
      whereArgs: [1],
    );

    final uncompletedRows = await db.query(
      'lesson_sessions',
      where: 'is_completed = ?',
      whereArgs: [0],
      orderBy: 'created_at DESC',
      limit: 1,
    );

    setState(() {
      _completed.clear();
      for (final r in completedRows) {
        final topic = jsonDecode(r['learning_item_ids'] as String);

        if (topic != null) {
          _completed.addAll((topic as List).map((id) => id.toString()));
        }
      }

      if (uncompletedRows.isNotEmpty) {
        _uncompletedSessionTopic =
            uncompletedRows.first['learning_item_ids'] as String?;
      } else {
        _uncompletedSessionTopic = null;
      }
    });
  }

  List<_FlatItem> _flatten(Syllabus syllabus) {
    final list = <_FlatItem>[];

    for (final subject in syllabus.subjects) {
      for (final module in subject.modules) {
        for (final item in module.learningItems) {
          list.add(_FlatItem(id: item.id, title: item.title));
        }
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // Listen to syllabus changes here (allowed) to refresh local state when current syllabus changes
    ref.listen<SyllabusState>(syllabusNotifierProvider, (previous, next) {
      final prevId = previous?.syllabus?.id;
      final nextId = next.syllabus?.id;

      if (prevId != nextId) {
        _loadState();

        // center the new current topic after state reload
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (nextId != null) {
            final key = _itemKeys[nextId];
            if (key != null && key.currentContext != null) {
              try {
                Scrollable.ensureVisible(
                  key.currentContext!,
                  alignment: 0.5,
                  duration: const Duration(milliseconds: 300),
                );
              } catch (_) {}
            }
          }
        });

        setState(() {});
      }
    });

    final syllabus = ref.watch(syllabusNotifierProvider).syllabus;

    if (syllabus == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Syllabus')),
        body: const Center(child: Text('No syllabus available')),
      );
    }

    // compute flat list to determine current and next topic ids
    final flat = _flatten(syllabus);

    String? currentTopicId;
    String? nextTopicId;

    if (flat.isNotEmpty) {
      int currentIndex = 0;

      if (_uncompletedSessionTopic != null) {
        final idx = flat.indexWhere((f) => f.id == _uncompletedSessionTopic);
        if (idx >= 0) currentIndex = idx;
      } else {
        final idx = flat.indexWhere((f) => !_completed.contains(f.id));
        if (idx >= 0) currentIndex = idx;
      }

      currentTopicId = flat[currentIndex].id;
      if (currentIndex + 1 < flat.length) {
        nextTopicId = flat[currentIndex + 1].id;
      }
    }

    // After the frame, try to center the current topic in view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentTopicId != null) {
        final key = _itemKeys[currentTopicId];
        if (key != null && key.currentContext != null) {
          try {
            Scrollable.ensureVisible(
              key.currentContext!,
              alignment: 0.5,
              duration: const Duration(milliseconds: 300),
            );
          } catch (_) {}
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(syllabus.title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.mobileMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                syllabus.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: syllabus.subjects.length,
                  itemBuilder: (context, sIndex) {
                    final subject = syllabus.subjects[sIndex];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          ...subject.modules.map((module) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    module.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  ...module.learningItems.map((item) {
                                    final isCompleted = _completed.contains(
                                      item.id,
                                    );
                                    final isCurrent = item.id == currentTopicId;
                                    final isNext = item.id == nextTopicId;

                                    final key = _itemKeys.putIfAbsent(
                                      item.id,
                                      () => GlobalKey(),
                                    );

                                    return Container(
                                      key: key,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        color: isCurrent
                                            ? AppColors.primaryContainer
                                            : isCompleted
                                            ? AppColors.surfaceLow
                                            : AppColors.surfaceContainer,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        title: Text(item.title),
                                        subtitle: Text(item.description ?? ''),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (isCompleted)
                                              const Icon(
                                                Icons.check_circle,
                                                color: AppColors.primary,
                                              )
                                            else if (isCurrent)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Text(
                                                  'Current',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            else if (isNext)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),

                                            const SizedBox(width: 8),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.play_arrow,
                                              ),
                                              color: AppColors.primary,
                                              onPressed: () async {
                                                context.push(
                                                  Routes.lessonSession,
                                                  extra: [item.id],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlatItem {
  final String id;
  final String title;
  _FlatItem({required this.id, required this.title});
}
