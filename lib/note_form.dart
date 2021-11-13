import 'package:flutter/material.dart';

class NoteForm extends StatelessWidget {
  final String? title;
  final String? desc;
  final ValueChanged<String> changedTitle;
  final ValueChanged<String> changedDesc;

  const NoteForm({
    Key? key,
    this.title = '',
    this.desc = '',
    required this.changedTitle,
    required this.changedDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTitle(),
            const SizedBox(
              height: 8,
            ),
            _buildDesc(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _buildTitle() => TextFormField(
        initialValue: title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
          border: InputBorder.none,
        ),
        onChanged: changedTitle,
      );

  _buildDesc() => TextFormField(
        initialValue: desc,
        maxLines: 9,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          hintText: 'Description',
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 20,
          ),
          border: InputBorder.none,
        ),
        onChanged: changedDesc,
      );
}
