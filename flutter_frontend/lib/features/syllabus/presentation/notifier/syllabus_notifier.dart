import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/learning_goal.dart';
import '../../domain/entities/learning_item.dart';
import '../../domain/entities/module.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/syllabus.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../domain/repositories/syllabus_repository.dart';
import '../state/syllabus_state.dart';
import '../state/syllabus_status.dart';

class SyllabusNotifier extends StateNotifier<SyllabusState> {
  final SyllabusRepository repository;
  final LearningGoalRepository goalRepository;

  SyllabusNotifier(this.repository, this.goalRepository)
    : super(const SyllabusState()) {
    Future.microtask(_initialize);
  }

  Future<void> _initialize() async {
    try {
      final id = await repository.getCurrentSyllabusId();

      if (id != null && id.isNotEmpty) {
        await loadSyllabus(id);
        return;
      }

      // no current syllabus — try to load current goal's latest syllabus
      String? goalId = await repository.getCurrentGoalId();

      if (goalId == null) {
        // if there's no current goal, pick the first saved goal
        final goals = await goalRepository.getGoals();

        if (goals.isNotEmpty) {
          goalId = goals.first.id;
        }
      }

      if (goalId != null) {
        final latest = await repository.getLatestSyllabusForGoal(goalId);

        if (latest != null) {
          await loadSyllabus(latest.id);
        } else {
          // generate syllabus for the selected goal
          final goal = await goalRepository.getGoalById(goalId);

          if (goal != null) {
            await generateSyllabus(goal: goal);
          }
        }
      }
    } catch (e) {
      state = state.copyWith(
        status: SyllabusStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Generate syllabus from goal
  Future<void> generateSyllabus({required LearningGoal goal}) async {
    state = state.copyWith(status: SyllabusStatus.generating);

    try {
      final syllabus = await repository.generateFromGoal(goal: goal);

      state = state.copyWith(syllabus: syllabus, status: SyllabusStatus.ready);
    } catch (e) {
      state = state.copyWith(
        status: SyllabusStatus.error,

        errorMessage: e.toString(),
      );
    }
  }

  /// Load saved syllabus
  Future<void> loadSyllabus(String id) async {
    state = state.copyWith(status: SyllabusStatus.loading);

    try {
      final syllabus = await repository.getSyllabusById(id);

      // persist current syllabus selection
      if (syllabus != null) {
        await repository.setCurrentSyllabusId(syllabus.id);
      }

      state = state.copyWith(syllabus: syllabus, status: SyllabusStatus.ready);
    } catch (e) {
      state = state.copyWith(
        status: SyllabusStatus.error,

        errorMessage: e.toString(),
      );
    }
  }

  /// Update whole syllabus tree
  void updateSyllabus(Syllabus syllabus) {
    state = state.copyWith(syllabus: syllabus);
  }

  /// Save user changes
  Future<void> saveChanges() async {
    final syllabus = state.syllabus;

    if (syllabus == null) {
      return;
    }

    state = state.copyWith(status: SyllabusStatus.saving);

    try {
      await repository.updateSyllabus(syllabus);

      // ensure current syllabus is set
      await repository.setCurrentSyllabusId(syllabus.id);

      state = state.copyWith(status: SyllabusStatus.ready);
    } catch (e) {
      state = state.copyWith(
        status: SyllabusStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Replace syllabus after editing
  void replaceSubject(Subject updatedSubject) {
    final syllabus = state.syllabus;

    if (syllabus == null) {
      return;
    }

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id == updatedSubject.id) {
        return updatedSubject;
      }

      return subject;
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Add new subject
  void addSubject(Subject subject) {
    final syllabus = state.syllabus;

    if (syllabus == null) {
      return;
    }

    state = state.copyWith(
      syllabus: syllabus.copyWith(subjects: [...syllabus.subjects, subject]),
    );
  }

  /// Rename a Module
  void renameModule({
    required String subjectId,
    required String moduleId,
    required String name,
  }) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final modules = subject.modules.map((module) {
        if (module.id != moduleId) return module;

        return module.copyWith(name: name);
      }).toList();

      return subject.copyWith(modules: modules);
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Rename a Topic
  void renameTopic({
    required String subjectId,
    required String moduleId,
    required String topicId,
    required String title,
  }) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final modules = subject.modules.map((module) {
        if (module.id != moduleId) return module;

        final items = module.learningItems.map((item) {
          if (item.id != topicId) return item;

          return item.copyWith(title: title);
        }).toList();

        return module.copyWith(learningItems: items);
      }).toList();

      return subject.copyWith(modules: modules);
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Delete a Topic
  void removeTopic({
    required String subjectId,
    required String moduleId,
    required String topicId,
  }) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final modules = subject.modules.map((module) {
        if (module.id != moduleId) return module;

        return module.copyWith(
          learningItems: module.learningItems
              .where((e) => e.id != topicId)
              .toList(),
        );
      }).toList();

      return subject.copyWith(modules: modules);
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Delete a Module
  void removeModule({required String subjectId, required String moduleId}) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      return subject.copyWith(
        modules: subject.modules.where((e) => e.id != moduleId).toList(),
      );
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Add Topic
  void addTopic({required String subjectId, required String moduleId}) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final modules = subject.modules.map((module) {
        if (module.id != moduleId) return module;

        return module.copyWith(
          learningItems: [
            ...module.learningItems,
            LearningItem(
              id: const Uuid().v4(),
              title: "New Topic",
              description: "",
              content: "",
            ),
          ],
        );
      }).toList();

      return subject.copyWith(modules: modules);
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Add Module
  void addModule({required String subjectId}) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      return subject.copyWith(
        modules: [
          ...subject.modules,
          Module(
            id: const Uuid().v4(),
            name: "New Module",
            description: "",
            learningItems: const [],
          ),
        ],
      );
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// ReOrder Topics
  void reorderTopics({
    required String subjectId,
    required String moduleId,
    required int oldIndex,
    required int newIndex,
  }) {
    final syllabus = state.syllabus;
    if (syllabus == null) return;

    final subjects = syllabus.subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final modules = subject.modules.map((module) {
        if (module.id != moduleId) return module;

        final items = [...module.learningItems];

        final moved = items.removeAt(oldIndex);
        items.insert(newIndex, moved);

        return module.copyWith(
          learningItems: [for (int i = 0; i < items.length; i++) items[i]],
        );
      }).toList();

      return subject.copyWith(modules: modules);
    }).toList();

    state = state.copyWith(syllabus: syllabus.copyWith(subjects: subjects));
  }

  /// Remove syllabus
  Future<void> deleteSyllabus() async {
    final syllabus = state.syllabus;

    if (syllabus == null) {
      return;
    }

    await repository.deleteSyllabus(syllabus.id);

    state = const SyllabusState();
  }
}
