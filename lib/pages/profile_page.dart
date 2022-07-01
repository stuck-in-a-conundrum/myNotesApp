import 'package:flutter/material.dart';
import 'package:todo_sqlite/api_manager/user_helper.dart';
import 'package:todo_sqlite/models/user_model.dart';
import 'package:todo_sqlite/strings.dart';
import 'package:todo_sqlite/widgets/profile_data.dart';
import 'common/header_widget.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  logout() {
    return IconButton(
      icon: const Icon(
        Icons.logout_rounded,
        size: 27,
      ),
      tooltip: "Logout",
      onPressed: () async {
        await addToken('');
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
        actions: [logout()],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: profileData(context),
            ),
          ],
        ),
      ),
    );
  }

  profileData(BuildContext context) {
    //User user = await UserManager().getProfile();
    return FutureBuilder<User>(
        future: UserManager().getProfile(),
        builder: (context, snapshot) {
          print(snapshot.data?.name);
          if (snapshot.hasData) {
            if (snapshot.data!.username.isNotEmpty) {
              return buildText(snapshot.data!);
            } else {
              return const Center(
                child: Text("some error occured"),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
