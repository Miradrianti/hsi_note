import 'package:aplikasi_catatan/bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_event.dart';
import '../database/notes.dart';
import '../model/note.dart';

class MyBottomBar extends StatefulWidget {
  final int? noteId;
  final Note? note;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController usernameController;
  final VoidCallback? onOpenBottomSheet;

  const MyBottomBar({
    super.key, 
    this.note, 
    this.noteId,
    required this.titleController,
    required this.contentController,
    required this.usernameController,
    this.onOpenBottomSheet,
  });

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  String lastEdited = "";
  String user = "";

  @override
  void initState() {
    super.initState();
    lastEdited = widget.note?.createdTime.toString() ?? "";
    user = widget.note?.username.toString() ?? "";
  }

  void _saveNote() {
    final title = widget.titleController.text.trim();
    final content = widget.contentController.text.trim();
    final username = widget.usernameController.text.trim();

    if (title.isEmpty && username.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Catatan kosong tidak disimpan")),
      );
      return;
    }

    final newNote = Note(
      id: widget.noteId,
      username: username,
      title: title,
      content: content,
      createdTime: DateTime.now(),
    );

    if (widget.noteId == null) {
      // note baru
      context.read<NoteBloc>().add(AddNote(newNote));
    } else {
      // update note lama
      context.read<NoteBloc>().add(SaveNote(newNote));
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text('Last Edited: $lastEdited', textAlign: TextAlign.left,)),
            Expanded(
              flex: 2,
              child: FloatingActionButton(
                shape: BeveledRectangleBorder(),
                backgroundColor: Color.fromRGBO(57, 70, 117, 1),
                foregroundColor: Colors.white,
                tooltip: 'Edit',
                onPressed: () async {
                  if (widget.onOpenBottomSheet != null) {
                    widget.onOpenBottomSheet!();
                  }
                  await showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 56,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close_rounded),
                                    iconSize: 24,
                                    color: Colors.grey,
                                    tooltip: 'close',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 56,
                                  child: TextButton(
                                    onPressed: () {
                                      _saveNote();
                                      Navigator.pop(context); // tutup bottomsheet
                                      ScaffoldMessenger.of(this.context).showSnackBar(
                                        const SnackBar(content: Text("Note marked as finished")),
                                      );
                                    }, 
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check, color: Colors.black,size: 20,),
                                        const SizedBox(width: 16,),
                                        const Text("Mark as Finished", style: TextStyle(color: Colors.black,fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 56,
                                  child: TextButton(
                                    onPressed: () async {
                                      if (widget.noteId != null) {
                                        await NoteDatabase.instance.deleteNotebyId(widget.noteId!);
                                      }
                                      if (mounted) {
                                      Navigator.pop(this.context); // tutup bottomsheet
                                      Navigator.pop(this.context, true); // balik ke home
                                      ScaffoldMessenger.of(this.context).showSnackBar(
                                        const SnackBar(content: Text("Note deleted")),
                                      );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.delete_outline, color: Colors.red, size: 20,),
                                        const SizedBox(width: 16,),
                                        const Text("Delete Note", style: TextStyle(color: Colors.red, fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.more_horiz),
              ),
            ),
          ],
        ),
      );
  }
}