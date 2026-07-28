import 'package:equatable/equatable.dart';
import 'package:mnemosyne_learn/features/syllabus/domain/entities/syllabus.dart';

import 'syllabus_status.dart';

class SyllabusState extends Equatable {
  final Syllabus? syllabus;

  final SyllabusStatus status;

  final String? errorMessage;

  const SyllabusState({
    this.syllabus,
    this.status = SyllabusStatus.initial,
    this.errorMessage,
  });

  SyllabusState copyWith({
    Syllabus? syllabus,
    SyllabusStatus? status,
    String? errorMessage,
  }) {
    return SyllabusState(
      syllabus: syllabus ?? this.syllabus,

      status: status ?? this.status,

      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [syllabus, status, errorMessage];
}
