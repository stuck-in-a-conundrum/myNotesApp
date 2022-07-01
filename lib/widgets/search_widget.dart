import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/notes_model.dart';
import 'package:todo_sqlite/pages/edit_page.dart';

class Search extends SearchDelegate<String> {
  final List<Note> notes;
  final Function refresh;
  final bool isLogged;
  Search({required this.notes, required this.refresh, required this.isLogged});
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
    final suggestNotes = List<List>.generate(
      notes.length,
      (i) => [notes[i].title, notes[i].id],
    );
    final shownTitles = query.isEmpty
        ? suggestNotes
        : suggestNotes
            .where((element) => element[0].startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(
          shownTitles[index][0],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        tileColor: Colors.white,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EditNotePage(
              isLogged: isLogged,
              refresh: refresh,
              note: notes[notes.indexWhere(
                  (element) => element.id == shownTitles[index][1], index)],
            ),
          ),
        ),
      ),
      itemCount: shownTitles.length,
    );
  }
}
