import 'package:equatable/equatable.dart';
import '../model/note.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int noteId;

  const DeleteNote(this.noteId);

  @override
  List<Object> get props => [noteId];
}

class SaveNote extends NoteEvent {
  final Note note;
  final bool isNew; // true kalau add, false kalau update

  const SaveNote(this.note, {this.isNew = false});

  @override
  List<Object> get props => [note, isNew];
}

class UpdateNoteTags extends NoteEvent {
  final List<String> tags;
  
  const UpdateNoteTags(this.tags);

  @override
  List<Object> get props => [tags];
}