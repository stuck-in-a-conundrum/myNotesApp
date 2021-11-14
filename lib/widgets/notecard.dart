import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/notes_model.dart';

final lightColors = [
  Colors.amber.shade200,
  Colors.lightGreen.shade200,
  Colors.lightBlue.shade100,
  Colors.orange.shade100,
  Colors.pink[100],
  Colors.tealAccent.shade100,
  Colors.lime[200],
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = lightColors[index % lightColors.length];

    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              DateFormat.yMMMd().format(note.createdTime),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              note.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 120;
      case 1:
        return 150;
      case 2:
        return 130;
      case 3:
        return 110;
      default:
        return 100;
    }
  }
}
