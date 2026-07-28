import 'package:flutter_riverpod/legacy.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/repositories/syllabus_repository.dart';
import 'package:mnemosyne_learn/features/syllabus/presentation/state/syllabus_status.dart';

import '../../domain/entities/subject.dart';
import '../state/syllabus_state.dart';

class SyllabusNotifier extends StateNotifier<SyllabusState> {
  final SyllabusRepository repository;

  SyllabusNotifier(this.repository) : super(const SyllabusState());

  /// Generate syllabus from goal

  Future<void> generateSyllabus({required String goalId}) async {
    state = state.copyWith(status: SyllabusStatus.generating);

    try {
      final syllabus = await repository.generateFromGoal(
        learningGoalId: goalId,
      );

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
