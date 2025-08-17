import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/notes.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabase noteDatabase;

  NoteBloc(this.noteDatabase) : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<SaveNote>(_onSaveNote);
    on<UpdateNoteTags>(_onUpdateNoteTags);
  }

   Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final notes = await NoteDatabase.instance.readAllNotes();
      emit(state.copyWith(status: NoteStatus.success, notes: notes));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    await noteDatabase.create(event.note);
    final notes = await noteDatabase.readAllNotes();
    emit(state.copyWith(notes: notes));
  }

  Future<void> _onSaveNote(SaveNote event, Emitter<NoteState> emit) async {
    if (event.isNew) {
      await noteDatabase.create(event.note);
    } else {
      await noteDatabase.update(event.note);
    }
    final notes = await noteDatabase.readAllNotes();
    emit(state.copyWith(notes: notes));
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    await noteDatabase.deleteNotebyId(event.noteId);
    final notes = await noteDatabase.readAllNotes();
    emit(state.copyWith(notes: notes));
  }
  
  void _onUpdateNoteTags(UpdateNoteTags event, Emitter<NoteState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

}