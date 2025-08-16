import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/database/notes.dart';
import 'package:aplikasi_catatan/model/note.dart';
import 'package:aplikasi_catatan/view/write_note.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future _loadNotes() async {
    final loadedNotes = await NoteDatabase.instance.readAllNotes();
    setState(() {
      notes = loadedNotes;
      isLoading = false;
    });
  }

  Future addNote() async {
    final now = DateTime.now().toIso8601String();
    await NoteDatabase.instance.create(
      Note(
        username: "test",
        title: "Judul Catatan",
        content: "Isi catatan di sini...",
        date: now,
      ),
    );
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notes.isEmpty
            ? _buildEmptyState()
            : _buildNotesList(),
      floatingActionButton:SafeArea(
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WriteNote()),
            );
            _loadNotes();
          },
          backgroundColor: Color.fromRGBO(57, 70, 117, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(80),
          ),
          child: const Icon(Icons.add, size: 30,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/icon1.png',
              width: 245,
              height: 219,
            ),
            RegularText.title('Start Your Journey'),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: RegularText.description2(
                  'Every big step start with small step. \n'
                  'Notes your first idea and start your journey!',
              ),
            ),
          ]
        ), 
      ),
    );
  }

Widget _buildNotesList() {
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(
            "${note.content}\nOleh: ${note.username} | ${note.date}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            // nanti bisa ke halaman detail note
          },
        );
      },
    );
  }
}