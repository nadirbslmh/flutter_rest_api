import 'package:flutter/material.dart';
import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note_input.dart';
import 'package:flutter_rest_api/services/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  NoteService service = NoteService(
    client: HttpClient(),
  );

  final titleInputController = TextEditingController();
  final contentInputController = TextEditingController();

  bool _isLoading = false;

  void _createNote() async {
    setState(() {
      _isLoading = true;
    });

    String title = titleInputController.text;
    String content = contentInputController.text;
    NoteInput noteInput = NoteInput(title: title, content: content);

    await service.createNote(noteInput: noteInput);
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        _isLoading = false;
      });

      _showMessage();
      titleInputController.clear();
      contentInputController.clear();
    });
  }

  void _showMessage() {
    final snackBar = SnackBar(
      content: const Text('Note created!'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    titleInputController.dispose();
    contentInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Note'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a note title',
                    ),
                    controller: titleInputController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a note content',
                    ),
                    maxLines: 5,
                    minLines: 1,
                    controller: contentInputController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _createNote();
                  },
                  child: const Text('Create'),
                )
              ],
            ),
    );
  }
}
