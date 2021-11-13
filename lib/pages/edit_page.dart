import 'package:flutter/material.dart';
import 'package:todo_sqlite/database/options.dart';
import 'package:todo_sqlite/models/notes_model.dart';
import 'package:todo_sqlite/note_form.dart';

class EditNotePage extends StatefulWidget {
  final Note? note;
  const EditNotePage({Key? key, this.note}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late String title;
  late String desc;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';
    desc = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [remove()],
        title: const Text('Add or Edit Note'),
      ),
      body: Form(
        child: NoteForm(
          title: title,
          desc: desc,
          changedTitle: (title) => setState(() => this.title = title),
          changedDesc: (desc) => setState(() => this.desc = desc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addupdateNote,
        child: const Icon(
          Icons.save,
          size: 38,
        ),
        tooltip: "save",
      ),
    );
  }

//  save() => IconButton(onPressed: addupdateNote, icon: const Icon(Icons.save));

  remove() => IconButton(onPressed: deleteNote, icon: const Icon(Icons.delete));

  addupdateNote() async {
    if (title.isNotEmpty) {
      if (widget.note != null) {
        await updateNote();
      } else {
        await add();
      }
    }
    Navigator.of(context).pop();
  }

  add() {
    final note =
        Note(title: title, description: desc, createdTime: DateTime.now());
    create(note);
  }

  updateNote() {
    final note = widget.note!.copy(title: title, description: desc);
    return update(note);
  }

  deleteNote() async {
    if (widget.note == null) {
      Navigator.of(context).pop;
    } else {
      final id = widget.note!.id;
      await delete(id!);
    }
    Navigator.of(context).pop();
  }
}
