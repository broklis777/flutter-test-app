import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/note.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<AppProvider>().notes;

    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter note...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty &&
                        titleController.text.trim().isNotEmpty) {
                      context.read<AppProvider>().addNote(
                        titleController.text.trim(),
                        _controller.text.trim(),
                      );
                      _controller.clear();
                      titleController.clear();
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: notes.isEmpty
                ? Center(child: Text("No notes yet"))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return GestureDetector(
                        onLongPress: () {
                          context.read<AppProvider>().deleteNote(note.id);
                        },
                        child: Card(
                          color: Colors.amber[100],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(note.content),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
