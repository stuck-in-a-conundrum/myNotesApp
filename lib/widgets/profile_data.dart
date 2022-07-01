import 'package:flutter/material.dart';
import 'package:todo_sqlite/models/user_model.dart';

Widget buildText(User user) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 5, color: Colors.white),
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
          size: 80,
          color: Colors.grey.shade300,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        user.name!,
        style:const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ...ListTile.divideTiles(
                          color: Colors.grey,
                          tiles: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              subtitle: const Text("Username"),
                              title: Text(
                                  user.username),
                            ),
                            ListTile(
                              leading:const Icon(Icons.email),
                              subtitle: const Text("Email"),
                              title: Text(user.email!),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
