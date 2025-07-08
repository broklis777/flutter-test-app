import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';

class AppProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(String name, String content) {
    final newNote = Note(id: const Uuid().v4(), name: name, content: content);
    _notes.add(newNote);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.remove((note) => note.id == id);
    notifyListeners();
  }

  String username = "broklis";

  void updateUsername(String name) {
    username = name;
    notifyListeners();
  }
}
