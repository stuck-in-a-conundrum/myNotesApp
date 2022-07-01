import 'dart:convert';
import 'package:todo_sqlite/strings.dart';
import 'package:http/http.dart' as http;
import '../models/notes_model.dart';

class TodoManager {
  Future<int> addNote(Note note) async {
    String json = jsonEncode(note);
    print(json);
    var response = await http.post(Uri.parse('${baseUrl}note/create/'),
        headers: {
          "Authorization": "Token $token",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);
    print('add response ${response.body}');
    if (response.statusCode == 200) {
      return 1;
    }
    return 0;
  }

  Future<List<Note>> getNote() async {
    List<Note> notes = [];
    await getToken();
    var client = http.Client();
    var response = await client.get(
      Uri.parse('${baseUrl}notes/'),
      headers: {
        "Authorization": "Token $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      //print(response.body);
      List note = jsonDecode(response.body);
      for (var item in note) {
        notes.add(
          Note(
            title: item['title'],
            id: item['_id'],
            color: item['color'],
            createdTime: DateTime.parse(item['createdTime']),
            description: item['description'],
          ),
        );
      }
      return notes;
    }
    return notes;
  }

  Future<int> deleteNote(int id) async {
    var response = await http.delete(
      Uri.parse('${baseUrl}notes/$id/'),
      headers: {
        "Authorization": "Token $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 204) {
      return 1;
    }
    return 0;
  }

  Future<int> updateNote(Note note) async {
    print(note.id);
    print(jsonEncode(note));
    var response = await http.put(
      Uri.parse("${baseUrl}notes/${note.id}/"),
      headers: {
        "Authorization": "Token $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(note),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 1;
    }
    return 0;
  }
}
