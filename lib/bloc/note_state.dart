import 'package:equatable/equatable.dart';

import '../model/note.dart';

enum NoteStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;
  final String? errorMessage;
  final List<String> tags;

  const NoteState({
    this.status = NoteStatus.initial,
    this.notes = const [],
    this.errorMessage,
    this.tags = const [],
  });

  NoteState copyWith({
    NoteStatus? status,
    List<Note>? notes,
    List<String>? tags,
    String? errorMessage,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notes, errorMessage];
}