import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note.dart';
import 'package:flutter_rest_api/models/note_input.dart';

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

  Future<Note?> createNote({
    required NoteInput noteInput,
  }) async {
    var note = await client.createNote(noteInput: noteInput);
    return note;
  }

  Future<Note?> updateNote({
    required String id,
    required NoteInput noteInput,
  }) async {
    var note = await client.updateNote(id: id, noteInput: noteInput);
    return note;
  }

  Future<Note?> deleteNote({
    required String id,
  }) async {
    var note = await client.deleteNote(id: id);
    return note;
  }
}
