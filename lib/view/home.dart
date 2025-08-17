import 'package:aplikasi_catatan/bloc/login_bloc.dart';
import 'package:aplikasi_catatan/bloc/login_event.dart';
import 'package:aplikasi_catatan/components/note_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/database/notes.dart';
import 'package:aplikasi_catatan/model/note.dart';
import 'package:aplikasi_catatan/view/write_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (!mounted) return;
    setState(() {
      notes = loadedNotes;
      isLoading = false;
    });
  }

  Future addNote() async {
    await NoteDatabase.instance.create(
      Note(
        username: "test",
        title: "Judul Catatan",
        content: "Isi catatan di sini...",
        createdTime: DateTime.now(),
      ),
    );
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar.home(
        onLogoutPressed: () {
          context.read<LoginBloc>().add(LogoutRequested());
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notes.isEmpty
            ? _buildEmptyState()
            : _buildNotesList(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WriteNote()),
            ).then((value) {
            if (value == true) _loadNotes();
            });
          },
          backgroundColor: Color.fromRGBO(57, 70, 117, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          child: const Icon(Icons.add, size: 30,),
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
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
        key: Key(note.id.toString()),
        background: Container(
          color: Colors.grey,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) async {
          await NoteDatabase.instance.deleteNotebyId(note.id!);
          if (!mounted) return;
          setState(() => notes.removeAt(index));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Catatan dihapus"))
          );
        },
        child: NotesCard(
          note: note,
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteNote(note: note),
              ),
            );
            if (result == true) _loadNotes();
          },
          onDelete: () async {
            await NoteDatabase.instance.deleteNotebyId(note.id!);
            if (!mounted) return;
            setState(() {
              notes.removeAt(index);  
            });
          }
        )
        );
      },
    );
  }
}