import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aplikasi_catatan/model/note.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (kIsWeb) {
      // Gunakan databaseFactory versi web
      databaseFactory = databaseFactoryFfiWeb;
      return await databaseFactory.openDatabase(filePath,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: _createDB,
          ));
    } else {
      // Mobile / Desktop
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    }
  }
  
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdTime TEXT NOT NULL,
        tags TEXT
      )
    ''');
  }

  Future<int> create(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query('notes', orderBy: 'createdTime DESC');
    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<int> insert(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<Note?> getNoteById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteNotebyId(int id) async {
    final db = await instance.database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}