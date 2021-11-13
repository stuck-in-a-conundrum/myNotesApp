import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_sqlite/database/notes_db.dart';
import 'package:todo_sqlite/database/options.dart';
import 'package:todo_sqlite/notecard.dart';
import 'package:todo_sqlite/pages/edit_page.dart';
import '../models/notes_model.dart';
import 'package:animations/animations.dart';

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
      floatingActionButton: buildAddButton(context, refreshNotes),
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

          return OpenContainer(
            closedBuilder: (context, void openContainer) =>
                NoteCardWidget(note: note, index: index),
            closedColor: Colors.transparent,
            openBuilder: (context, _) =>
                EditNotePage(refresh: refreshNotes, note: note),
            transitionDuration: const Duration(milliseconds: 600),
            transitionType: ContainerTransitionType.fade,
          );
        },
      );
}

Widget buildAddButton(BuildContext context, Function refresh) {
  return OpenContainer(
    openBuilder: (context, _) {
      return EditNotePage(
        refresh: refresh,
      );
    },
    closedShape: const CircleBorder(),
    transitionDuration: const Duration(milliseconds: 750),
    transitionType: ContainerTransitionType.fade,
    closedBuilder: (context, void openContainer) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: const Icon(
        Icons.add,
        size: 30,
      ),
      height: 50,
      width: 50,
    ),
  );
}
