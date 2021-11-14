import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/notes_model.dart';
import 'package:todo_sqlite/pages/edit_page.dart';

class Search extends SearchDelegate<String> {
  final List<Note> notes;
  final Function refresh;
  Search({required this.notes, required this.refresh});
  @override
  List<Widget>? buildActions(BuildContext context) {
    // actions for the appBar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon left to the bar
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // result page on selections
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // shown data on search
    final suggestNotes =
        List<String>.generate(notes.length, (i) => notes[i].title);
    final shownTitles = query.isEmpty
        ? suggestNotes
        : suggestNotes
            .where((element) => element.startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(
          shownTitles[index],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        tileColor: Colors.white,
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => EditNotePage(
                  refresh: refresh,
                  note: notes[index],
                ))),
      ),
      itemCount: shownTitles.length,
    );
  }
}
