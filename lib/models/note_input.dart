import 'dart:convert';

NoteInput decode(String str) => NoteInput.fromJson(json.decode(str));

String encode(NoteInput data) => json.encode(data.toJson());

class NoteInput {
  NoteInput({
    required this.title,
    required this.content,
  });

  String title;
  String content;

  factory NoteInput.fromJson(Map<String, dynamic> json) => NoteInput(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
