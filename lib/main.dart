import 'package:flutter/material.dart';
import 'package:todo_sqlite/pages/login_page.dart';
import 'package:todo_sqlite/strings.dart';
import 'pages/homepage.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  _getToken() async {
    await getToken();

    return token;
  }

  @override
  Widget build(BuildContext context) {
    //bool isLogged = token == '';
    //print(isLogged);
    _getToken();
    print("here token get $token");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      //home: LoginPage(),
      home: FutureBuilder<dynamic>(
        future: _getToken(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data != '') {
            return const HomePage(
              isLogged: true,
            );
          }

          /// other way there is no user logged.
          return const LoginPage();
        },
      ),

      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[800],
      ),
    );
  }
}
