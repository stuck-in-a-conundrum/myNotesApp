import 'dart:convert';
import 'package:todo_sqlite/models/user_model.dart';
import 'package:todo_sqlite/strings.dart';
import 'package:http/http.dart' as http;

class UserManager {
  Future<String> register(User user) async {
    String jsonReg = jsonEncode(user);

    var response = await http.post(Uri.parse('${baseUrl}auth/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonReg);
    print(jsonReg);
    try {
      if (response.statusCode == 201) {
        var jToken = jsonDecode(response.body);
        final _token = jToken['token'];
        await addToken(_token);
      } else {
        Map<String, dynamic> error = jsonDecode(response.body);
        if (error.containsKey('email')) return error["email"][0];
        return error["username"][0];
      }
    } catch (exception) {
      return ('0');
    }
    return '1';
  }

  Future<String> login(User user) async {
    String jsonlog = jsonEncode(user);
    var response = await http.post(Uri.parse('${baseUrl}auth/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonlog);
    print(jsonlog);
    try {
      if (response.statusCode == 200) {
        var jToken = jsonDecode(response.body);
        final _token = jToken['token'];
        await addToken(_token);
      } else {
        Map<String, dynamic> error = jsonDecode(response.body);
        return error["non_field_errors"];
      }
    } catch (exception) {
      return ('0');
    }
    return '1';
  }

  Future<User> getProfile() async {
    User user = const User(username: "");
    var response = await http.Client().get(
      Uri.parse("${baseUrl}auth/profile/"),
      headers: {
        "Authorization": "Token $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      user = User.fromJson(
        jsonDecode(response.body),
      );
    }
    return user;
  }
}
