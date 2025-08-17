
import 'package:aplikasi_catatan/bloc/note_event.dart';
import 'package:aplikasi_catatan/database/db_initializer.dart';
import 'package:aplikasi_catatan/database/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'bloc/login_bloc.dart';
import 'bloc/note_bloc.dart';

void main() {
  final noteDatabase = NoteDatabase.instance;
  
  initDatabaseFactory();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
        BlocProvider<NoteBloc>(
          create: (_) => NoteBloc(noteDatabase)..add(LoadNotes()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}