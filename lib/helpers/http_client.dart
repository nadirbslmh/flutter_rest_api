import 'package:dio/dio.dart';
import 'package:flutter_rest_api/models/note.dart';
import 'package:flutter_rest_api/models/note_input.dart';

class HttpClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://644726c47bb84f5a3e391662.mockapi.io/api/v1';

  Future<List<Note>?> getNotes() async {
    List<Note>? notes;
    try {
      Response<List<dynamic>> response =
          await _dio.get<List<dynamic>>('$_baseUrl/notes');

      notes = response.data!
          .map((note) => Note.fromJson(note as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error occurred in Dio');
      } else {
        print('Error when sending request: ${e.message}');
      }
    }

    return notes;
  }

  Future<Note?> getNoteByID({
    required String id,
  }) async {
    Note? note;
    try {
      Response response = await _dio.get('$_baseUrl/notes/$id');
      note = Note.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error occurred in Dio');
      } else {
        print('Error when sending request: ${e.message}');
      }
    }

    return note;
  }

  Future<Note?> createNote({
    required NoteInput noteInput,
  }) async {
    Note? createdNote;
    try {
      Response response = await _dio.post(
        '$_baseUrl/notes',
        data: noteInput.toJson(),
      );

      createdNote = Note.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error occurred in Dio');
      } else {
        print('Error when sending request: ${e.message}');
      }
    }

    return createdNote;
  }

  Future<Note?> updateNote({
    required String id,
    required NoteInput noteInput,
  }) async {
    Note? updatedNote;
    try {
      Response response = await _dio.put(
        '$_baseUrl/notes/$id',
        data: noteInput.toJson(),
      );

      updatedNote = Note.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error occurred in Dio');
      } else {
        print('Error when sending request: ${e.message}');
      }
    }

    return updatedNote;
  }
}
