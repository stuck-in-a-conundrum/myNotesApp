const String tableNotes = 'notes';

class NoteFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdTime = 'createdTime';
  static const String color = 'color';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;
  final String? color;

  const Note({
    this.id,
    this.color,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.color: color,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.createdTime: createdTime.toIso8601String(),
      };

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
    String? color,
  }) =>
      Note(
        id: id ?? this.id,
        color: color ?? this.color,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        color: json[NoteFields.color] as String?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
      );
}
