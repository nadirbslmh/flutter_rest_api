import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  DateTime createdAt;
  String title;
  String content;
  String id;

  Note({
    required this.createdAt,
    required this.title,
    required this.content,
    required this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        createdAt: DateTime.parse(json["createdAt"]),
        title: json["title"],
        content: json["content"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "title": title,
        "content": content,
        "id": id,
      };
}
