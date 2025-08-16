import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/database/notes.dart';
import 'package:aplikasi_catatan/model/note.dart';
import 'package:flutter/material.dart';

class WriteNote extends StatefulWidget {
  final int? noteId;
  const WriteNote({super.key, this.noteId});

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _lastEdited = "";

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _loadNote();
    }
  }

  Future<void> _loadNote() async {
    final note = await NoteDatabase.instance.getNoteById(widget.noteId!);
    if (note != null) {
      setState(() {
        _titleController.text = note.title;
        _contentController.text = note.content;
        _lastEdited = note.date;
      });
    }
  }

  Future<void> _saveNote() async {
    final now = DateTime.now().toString();
    if (widget.noteId == null) {
      // insert baru
      await NoteDatabase.instance.insert(Note(
        username: "admin", 
        title: _titleController.text,
        content: _contentController.text,
        date: now,
      ));
    } else {
      // update
      await NoteDatabase.instance.update(Note(
        id: widget.noteId,
        username: "user123",
        title: _titleController.text,
        content: _contentController.text,
        date: now,
      ));
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context, true); // kembali dan refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.simple('back'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Judul",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Mulai tulis ...",
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text('Last Edited: $_lastEdited}', textAlign: TextAlign.left,)),
            Expanded(
              flex: 2,
              child: FloatingActionButton(
                shape: BeveledRectangleBorder(),
                backgroundColor: Color.fromRGBO(57, 70, 117, 1),
                foregroundColor: Colors.white,
                tooltip: 'Edit',
                onPressed: _saveNote,
                child: const Icon(Icons.more_horiz,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}