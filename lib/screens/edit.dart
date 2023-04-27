import 'package:flutter/material.dart';
import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note.dart';
import 'package:flutter_rest_api/models/note_input.dart';
import 'package:flutter_rest_api/services/note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.noteID,
  });

  final String noteID;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  NoteService service = NoteService(
    client: HttpClient(),
  );

  final titleInputController = TextEditingController();
  final contentInputController = TextEditingController();

  late Note? _note = Note(
    createdAt: DateTime.now(),
    title: "",
    content: "",
    id: "",
  );

  bool _isLoading = false;

  void _getNoteByID() async {
    setState(() {
      _isLoading = true;
    });

    _note = await service.getNoteByID(id: widget.noteID);
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        _isLoading = false;
      });

      titleInputController.text = _note!.title;
      contentInputController.text = _note!.content;
    });
  }

  void _updateNote() async {
    setState(() {
      _isLoading = true;
    });

    String title = titleInputController.text;
    String content = contentInputController.text;
    NoteInput noteInput = NoteInput(title: title, content: content);

    await service.updateNote(
      id: widget.noteID,
      noteInput: noteInput,
    );

    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        _isLoading = false;
      });

      _showMessage();
    });
  }

  void _showMessage() {
    final snackBar = SnackBar(
      content: const Text('Note updated!'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _getNoteByID();
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
        title: const Text('Edit a Note'),
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
                    _updateNote();
                  },
                  child: const Text('Update'),
                )
              ],
            ),
    );
  }
}
