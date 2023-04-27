import 'package:flutter/material.dart';
import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note.dart';
import 'package:flutter_rest_api/screens/edit.dart';
import 'package:flutter_rest_api/services/note.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key, required this.noteID});

  final String noteID;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  NoteService service = NoteService(
    client: HttpClient(),
  );

  late Note? _note = Note(
    createdAt: DateTime.now(),
    title: "",
    content: "",
    id: "",
  );

  void _getNoteByID() async {
    _note = await service.getNoteByID(id: widget.noteID);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _getNoteByID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note Details',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: _note == null || _note!.id == ""
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Text(
                      _note!.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Text(
                  _note!.content,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(
                noteID: _note!.id,
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
