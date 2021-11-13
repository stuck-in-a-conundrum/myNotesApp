import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_sqlite/database/notes_db.dart';
import 'package:todo_sqlite/database/options.dart';
import 'package:todo_sqlite/notecard.dart';
import 'package:todo_sqlite/pages/edit_page.dart';
import '../models/notes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDB.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    final tnotes = await getAll();
    setState(() => notes = tnotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Center(child: buildNotes(notes)),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Add Note',
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditNotePage()),
            );
            refreshNotes();
          }),
    );
  }

  Widget buildNotes(List<Note> notes) => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[notes.length - index - 1];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => EditNotePage(note: note)),
              );
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
