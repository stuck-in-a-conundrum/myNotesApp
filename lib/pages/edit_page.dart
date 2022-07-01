import 'package:flutter/material.dart';
import 'package:todo_sqlite/api_manager/notes_helper.dart';
import 'package:todo_sqlite/database/options.dart';
import 'package:todo_sqlite/models/notes_model.dart';
import 'package:todo_sqlite/widgets/note_form.dart';

class EditNotePage extends StatefulWidget {
  final Note? note;
  final Function refresh;
  final bool isLogged;
  final Color? noteColor;

  const EditNotePage({
    Key? key,
    this.note,
    this.noteColor,
    required this.isLogged,
    required this.refresh,
  }) : super(key: key);

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
      backgroundColor: widget.noteColor ?? Colors.grey[300],
      appBar: AppBar(
        backgroundColor: widget.noteColor,
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
    print(title);
    if (title.isNotEmpty) {
      if (widget.note != null) {
        await updateNote();
      } else {
        await add();
      }
    }
    widget.refresh();
    Navigator.of(context).pop();
  }

  add() async {
    print(widget.isLogged);
    final note = Note(
      title: title,
      description: desc,
      createdTime: DateTime.now(),
      color: widget.noteColor.toString(),
    );
    //print(note.toString());
    return widget.isLogged
        ? await TodoManager().addNote(note)
        : await create(note);
  }

  updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: desc,
      color: widget.noteColor.toString(),
    );
    return widget.isLogged
        ? await TodoManager().updateNote(note)
        : await update(note);
  }

  deleteNote() async {
    if (widget.note == null) {
      Navigator.of(context).pop;
    } else {
      final id = widget.note!.id;
      widget.isLogged ? await TodoManager().deleteNote(id!) : await delete(id!);
      widget.refresh();
      Navigator.of(context).pop();
    }
  }
}
