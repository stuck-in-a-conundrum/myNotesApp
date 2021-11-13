import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/database/notes_db.dart';
import 'package:todo_sqlite/models/notes_model.dart';

Future<Note> create(Note note) async {
  final db = await NotesDB.instance.database;
  final id = await db.insert(tableNotes, note.toJson());
  return note.copy(id: id);
}

Future<List<Map>> getVal(int id) async {
  final db = await NotesDB.instance.database;
  Future<List<Map<String, Object?>>> val =
      db.query(tableNotes, where: "_id = ?", whereArgs: [id]);
  return (val);
}

Future<List<Note>> getAll() async {
  final db = await NotesDB.instance.database;
  final val = await db.query(tableNotes);

  return val.map((json) => Note.fromJson(json)).toList();
}

Future<int> update(Note note) async {
  final db = await NotesDB.instance.database;
  return db.update(tableNotes, note.toJson(),
      where: '${NoteFields.id}=?', whereArgs: [note.id]);
}

Future<int> delete(int id) async {
  final db = await NotesDB.instance.database;
  return db.delete(
    tableNotes,
    where: '${NoteFields.id} = ?',
    whereArgs: [id],
  );
}
