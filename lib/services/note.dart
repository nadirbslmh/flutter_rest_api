import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note.dart';

class NoteService {
  const NoteService({
    required this.client,
  });

  final HttpClient client;

  Future<List<Note>?> getNotes() async {
    var notes = await client.getNotes();
    return notes;
  }

  Future<Note?> getNoteByID({
    required String id,
  }) async {
    var note = await client.getNoteByID(id: id);
    return note;
  }
}
