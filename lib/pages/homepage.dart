import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_sqlite/api_manager/notes_helper.dart';
import 'package:todo_sqlite/database/options.dart';
import 'package:todo_sqlite/pages/login_page.dart';
import 'package:todo_sqlite/pages/profile_page.dart';
import 'package:todo_sqlite/widgets/notecard.dart';
import 'package:todo_sqlite/pages/edit_page.dart';
import 'package:todo_sqlite/widgets/search_widget.dart';
import '../models/notes_model.dart';
import 'package:animations/animations.dart';

class HomePage extends StatefulWidget {
  final bool isLogged;
  const HomePage({Key? key, required this.isLogged}) : super(key: key);

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

  // @override
  // void dispose() {
  //   NotesDB.instance.close();
  //   super.dispose();
  // }

  Future refreshNotes() async {
    final List<Note> tnotes;
    print(widget.isLogged);
    if (widget.isLogged) {
      tnotes = await TodoManager().getNote();
    } else {
      tnotes = await getAll();
    }
    print(tnotes);
    setState(() => notes = tnotes);
  }

  search() {
    return IconButton(
      icon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 27,
      ),
      onPressed: () {
        showSearch(
          context: context,
          delegate: Search(
              notes: notes, refresh: refreshNotes, isLogged: widget.isLogged),
        );
      },
    );
  }

  profile() {
    return IconButton(
      icon: const Icon(
        Icons.account_circle_rounded,
        color: Colors.white,
        size: 45,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      },
    );
  }

  login() {
    return IconButton(
      icon: const Icon(
        Icons.login,
        color: Colors.white,
        size: 37,
      ),
      tooltip: 'Login',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: widget.isLogged ? profile() : login(),
        title: const Text(
          'My Notes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [search()],
      ),
      body: RefreshIndicator(
        onRefresh: refreshNotes,
        child: Center(
          child: buildNotes(notes),
        ),
      ),
      floatingActionButton: buildAddButton(context),
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
            closedBuilder: (context, void openContainer) => NoteCardWidget(
              note: note,
              index: notes.length - index - 1,
              isLogged: widget.isLogged,
            ),
            closedColor: Colors.transparent,
            openBuilder: (context, _) => EditNotePage(
              isLogged: widget.isLogged,
              refresh: refreshNotes,
              note: note,
              noteColor:
                  lightColors[(notes.length - index - 1) % lightColors.length],
            ),
            transitionDuration: const Duration(milliseconds: 600),
            transitionType: ContainerTransitionType.fade,
          );
        },
      );

  Widget buildAddButton(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, _) {
        return EditNotePage(
          isLogged: widget.isLogged,
          refresh: refreshNotes,
        );
      },
      closedShape: const CircleBorder(),
      transitionDuration: const Duration(milliseconds: 650),
      transitionType: ContainerTransitionType.fade,
      closedColor: Theme.of(context).primaryColor,
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
}
