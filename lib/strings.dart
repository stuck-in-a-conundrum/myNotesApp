import 'package:shared_preferences/shared_preferences.dart';

String token = '';
const String baseUrl = 'https://mynotes-api-backend.herokuapp.com/';
//const String baseUrl = 'http://192.168.199.131:8000/';

Future getToken() async {
  final pref = await SharedPreferences.getInstance();
  token = pref.getString('token') ?? '';

  ///return token;
}

Future addToken(String _token) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('token', _token);
  await getToken();
}
