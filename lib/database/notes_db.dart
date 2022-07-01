import 'package:sqflite/sqflite.dart';
import '../models/notes_model.dart';

class NotesDB {
  static final NotesDB instance = NotesDB._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE $tableNotes ADD COLUMN color TEXT");
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableNotes(
      ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${NoteFields.title} TEXT NOT NULL,
      ${NoteFields.description} TEXT NOT NULL,
      ${NoteFields.createdTime} TEXT NOT NULL
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  NotesDB._init();
}
