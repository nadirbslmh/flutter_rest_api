import 'package:dio/dio.dart';
import 'package:flutter_rest_api/models/note.dart';

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
}
