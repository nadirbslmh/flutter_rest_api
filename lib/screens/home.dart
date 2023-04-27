import 'package:flutter/material.dart';
import 'package:flutter_rest_api/helpers/http_client.dart';
import 'package:flutter_rest_api/models/note.dart';
import 'package:flutter_rest_api/screens/add.dart';
import 'package:flutter_rest_api/screens/details.dart';
import 'package:flutter_rest_api/services/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteService service = NoteService(
    client: HttpClient(),
  );

  late List<Note>? _notes = [];

  void _getNotes() async {
    _notes = await service.getNotes();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<void> _refreshNotes() async {
    _getNotes();
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: _notes == null || _notes!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshNotes,
              child: ListView.builder(
                itemCount: _notes!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_notes![index].title),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        _notes![index].id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoteDetailsScreen(
                            noteID: _notes![index].id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
