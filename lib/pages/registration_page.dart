import 'package:flutter/material.dart';
import 'package:todo_sqlite/api_manager/user_helper.dart';
import 'package:todo_sqlite/models/user_model.dart';
import 'package:todo_sqlite/pages/homepage.dart';
import 'common/theme_helper.dart';
import 'common/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();
  final _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: 150,
            child: const HeaderWidget(150, false, Icons.person_rounded),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 80.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          },
                          controller: _username,
                          decoration: ThemeHelper().textInputDecoration(
                              'Username', 'Enter your username'),
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                          controller: _name,
                          decoration: ThemeHelper()
                              .textInputDecoration('Name', 'Enter your name'),
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          decoration: ThemeHelper().textInputDecoration(
                              "E-mail address", "Enter your email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if ((val!.isNotEmpty) &&
                                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                          controller: _email,
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration(
                              "Password", "Enter your password"),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          controller: _password,
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "Register".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              submit();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  submit() async {
    final user = User(
        name: _name.text,
        email: _email.text,
        username: _username.text,
        password: _password.text);
    String res = await UserManager().register(user);
    if (res == '1') {
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => const HomePage(
            isLogged: true,
          ),
        ),
        ModalRoute.withName('/'),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res == '0' ? 'Error occured' : res)),
      );
    }
  }
}
